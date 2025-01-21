module Types
    class TodoType < BaseObject
        graphql_name "My Todo Type"
        description "A todo item"
        
        field :id, ID, null: false
        field :title, String, null: true
        field :description, String, null: true
        field :completed, Boolean, null: false
    end
end
