class Exercise < ApplicationRecord
  def import_to_typesense!
    self.class.typesense_collection.documents.create(
      {id: id.to_s}.merge(
        slice(:title, :description, :exercise_type, :body_part, :equipment, :level, :ranking)
      )
    )
  end

  def self.create_typesense_schema!
    schema = {
      name: "exercises",
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
    TypesenseClientManager.client.collections["exercises"]
  end
end
