module Mutations
    class CreateTodo < BaseMutation     
        argument :title, String, required: true, validates: {length: {maximum: 255}}
        argument :description, String, required: false, validates: {length: {maximum: 1000}}
        argument :completed, Boolean, required: false, default_value: false

        field :todo, Types::TodoType, null: false

        def resolve(title:, completed:, description:)
            todo = Todo.create!(
                title: title,
                description: description,
                completed: completed
            )
            { todo: todo }
        end
    end
end