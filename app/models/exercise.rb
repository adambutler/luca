class Exercise < ApplicationRecord
  has_many :activities

  TYPESENSE_COLLECTION_NAME = "#{Rails.env}_exercises"

  belongs_to :user, optional: true
  
  def self.suggested_exercises(user)
    Exercise.joins(activities: :workout)
      .where("workouts.user_id = ?", user.id)
      .group("exercises.id")
      .order("COUNT(exercises.id) DESC")
  end
  
  def import_to_typesense!
    self.class.typesense_collection.documents.create(
      {id: id.to_s}.merge(
        slice(:title, :description, :exercise_type, :body_part, :equipment, :level, :ranking)
      )
    )
  end

  def self.create_typesense_schema!
    schema = {
      name: TYPESENSE_COLLECTION_NAME,
      fields: [
        {name: "title", type: "string"},
        {name: "description", type: "string"},
        {name: "exercise_type", type: "string", facet: true},
        {name: "body_part", type: "string", facet: true},
        {name: "equipment", type: "string", facet: true},
        {name: "level", type: "string"},
        {name: "ranking", type: "float"}
      ],
      default_sorting_field: "ranking"
    }

    TypesenseClientManager.client.collections.create(schema)
  end

  def self.destroy_typesense_schema!
    typesense_collection.delete
  end

  def self.typesense_collection
    TypesenseClientManager.client.collections[TYPESENSE_COLLECTION_NAME]
  end
end
