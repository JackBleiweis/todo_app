module Mutations
    class UpdateTodo < BaseMutation
        argument :id, ID, required: true
        argument :title, String, required: false, validates: {length: {maximum: 255}}
        argument :completed, Boolean, required: false
        argument :description, String, required: false, validates: {length: {maximum: 1000}}

        field :todo, Types::TodoType, null: true
        field :errors, [String], null: false

        def resolve(id:, title: nil, completed: nil, description: nil)
            todo = Todo.find_by(id: id)
            return { todo: nil, errors: ["Todo not found"] } unless todo

            attributes = {title: title, description: description, completed: completed.nil? ? todo.completed : completed}.reject { |_, value| value.nil? }

            if (todo.update(attributes))
                { todo: todo, errors: [] }
            else
                { todo: nil, errors: todo.errors.full_messages }
            end
        end
    end
end
