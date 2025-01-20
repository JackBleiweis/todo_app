module Queries
    class TodosQuery < BaseQuery
        type [Types::TodoType], null: false
        argument :id, ID, required: false

        def resolve(id: nil)
            todos = Todo.all
            todos = todos.where(id: id) if id
            todos
        end
    end
end