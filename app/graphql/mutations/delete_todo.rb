module Mutations
    class DeleteTodo < BaseMutation
        argument :id, ID, required: true

        field :success, Boolean, null: false
        field :errors, [String], null: false

        def resolve(id:)
            todo = Todo.find_by(id: id)
            return { success: false, errors: ["Todo not found"] } unless todo

            if todo.destroy
                { success: true, errors: [] }
            else
                { success: false, errors: todo.errors.full_messages }
            end
        end
    end
end