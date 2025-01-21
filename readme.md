# My Todo App

## Backend

To run the backend, you need to install the dependencies and start the server.

```bash
cd backend
bundle install
bin/rails db:migrate
bin/rails server
```

## Run tests

```bash
cd backend
rails test test/models/todo_test.rb
```

## Example Queries:

### Fetch all todos:

```
query {
  todos {
    id
    title
    description
    completed
  }
}
```

### Fetch a single todo by id:

```
query {
  todo(id: 1) {
    id
    title
    description
    completed
  }
}
```

### Create a todo:

```
mutation {
  createTodo(input: {
    title: "Learn GraphQL"
    description: "Understand how mutations work"
    completed: false
  }) {
    todo {
      id
      title
      description
      completed
    }
  }
}
```

### Update a todo:

```
mutation{
  updateTodo(input:{
    id: 2
    title: "THISISNEW"
    completed: true
    description:"TEST"
  }) {
    todo {
      id
      title
      completed
      description
    }
    errors
  }
}
```

### Delete a todo:

```
mutation {
  deleteTodo(id: 2) {
    id
  }
  success
  errors
}
```

## Notes (For me):

### Ruby, rails and the backend in general

- `bundle install` is used to install the dependencies.
- `bin/rails server` or `rails s` is used to start the server.
- You need to run `db:migrate` when creating a new migration or after editing a migration.
- `db:rollback` is used to rollback the database to the previous state.
- If an old migration was edited, you must first rollback the previous migration before running the db:migrate command.

- Todo types are defined in the `app/graphql/types/todo_type.rb` file.
- This file is where you define the fields for the todo type.

- Todo mutations are defined in the `app/graphql/mutations/todo_mutations.rb` file.
- This file is where you define the mutations for the todo type.
- Mutations: Create, Update, Delete

- Todo queries are defined in the `app/graphql/queries/todo_queries.rb` file.
- This file is where you define the queries for the todo type.
- Queries: Read

- GraphQL validations are defined in the mutations and types files to restrict API calls, which is separate from database-level validations.
- Database validations are defined in `app/models/todo.rb`, where we set rules like title presence and length limits. Model-level validations are tested in the model's test file.

### Summary and some other notes (For me)

1. Our database model is `todo.rb`, this defines our database validations. 2. The database migration defines the actual table structure:

```
create_table :todos do |t|
    t.string :title, limit: 255
    t.string :description, limit: 1000
    t.boolean :completed, default: false
    t.timestamps
end
```

3. Along w/ todo_type.rb, graphql types are defined.

```
module Types
    class TodoType < BaseObject
        field :id, ID, null: false
        field :title, String, null: true
        field :description, String, null: true
        field :completed, Boolean, null: false
    end
end
```

The TodoAppSchema is the top level container that brings everything together, it conects queries (todo_queries.rb) and mutations (todo_mutations.rb) to the types (todo_type.rb) and handles errors and validation.

When a query comes in, the schema routes it to either a Query or Mutation resolver, which then calls the appropriate method in todo_queries.rb or todo_mutations.rb.

### Creating a new entity (Todo or TodoList)

1. Generate the Model and Migration

```
rails generate model Todo title:string description:text completed:boolean
```

2. Update the Migration to add any constraints (length, presence, etc.)

```
class CreateTodoLists < ActiveRecord::Migration[7.2]
  def change
    create_table :todo_lists do |t|
      t.string :name, null: false, limit: 255
      t.string :description, limit: 1000

      t.timestamps
    end
  end
end
```

3. Set up Model Relationships

```
class TodoList < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
end
```

4. Create the GraphQL type(s)

```
module Types
  class TodoListType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
```

5. Run the migrations

```
rails db:migrate
```
