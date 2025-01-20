module Types
  class QueryType < BaseObject
    field :todo, Types::TodoType, null: true do
      argument :id, ID, required: true
    end

    field :todos, [Types::TodoType], null: false

    def todo(id:)
      Todo.find_by(id: id) || raise(GraphQL::ExecutionError, "No todo found with id #{id}")
    end

    def todos
      Todo.all
    end
  end
end
