module Search
  class Exercise
    COLLECTION_NAME = "#{Rails.env}_exercises"

    SCHEMA = {
      name: COLLECTION_NAME,
      fields: [
        {name: "title", type: "string"},
        {name: "description", type: "string"},
        {name: "exercise_type", type: "string", facet: true},
        {name: "body_part", type: "string", facet: true},
        {name: "equipment", type: "string", facet: true},
        {name: "level", type: "string"},
        {name: "ranking", type: "float"},
        {name: "owner", type: "string", facet: true, optional: true},
        {name: "is_public", type: "bool", facet: true}
      ],
      default_sorting_field: "ranking"
    }

    def self.create_typesense_schema!
      TypesenseClientManager.client.collections.create(SCHEMA)
    end

    def self.destroy_typesense_schema!
      typesense_collection.delete
    end

    def self.typesense_collection
      TypesenseClientManager.client.collections[COLLECTION_NAME]
    end

    def self.import!(exercise)
      typesense_collection.documents.create(
        {
          id: exercise.id.to_s,
          owner: exercise.user ? exercise.user.to_global_id.to_s : nil,
          is_public: exercise.user.blank?
        }.merge(
          exercise.slice(:title, :description, :exercise_type, :body_part, :equipment, :level, :ranking)
        )
      )
    end

    def self.delete!(exercise)
      typesense_collection.documents[exercise.id.to_s].delete
    end
    
    def self.search(user:, query:)
      search_parameters = {
        q: query,
        query_by: "title",
        sort_by: "ranking:desc",
        filter_by: "is_public:true || owner:'#{user.to_global_id.to_s}'"
      }
      
      typesense_collection.documents.search(search_parameters)
    end
  end
end
