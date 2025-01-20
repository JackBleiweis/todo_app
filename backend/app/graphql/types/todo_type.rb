module Types
    class TodoType < BaseObject
        field :id, ID, null: false
        field :title, String, null: true    
        field :description, String, null: true
        field :completed, Boolean, null: false
    end
end
