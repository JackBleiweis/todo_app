module Mutations
    class CompletionTodo < BaseMutation
        argument :id, ID, required: true

        field :todo, Types::TodoType, null: false
        field :errors, [String], null: false

        def resolve(id:)
            todo = Todo.find_by(id: id)
            return {todo: nil, errors: ["Todo not found"]} unless todo

            if (todo.update(completed: !todo.completed))
                { todo: todo, errors: [] }
            else
                { todo: nil, errors: todo.errors.full_messages }
            end
        end
    end
end