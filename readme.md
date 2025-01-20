# My Todo App

## Backend

To run the backend, you need to install the dependencies and start the server.

```bash
cd backend
bundle install
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

## Notes about ruby, rails and the backend in general (For me):

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
