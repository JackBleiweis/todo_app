import { useQuery, useMutation } from "@apollo/client";
import { gql } from "@apollo/client";

const GET_TODOS = gql`
  query GetTodos {
    todos {
      id
      title
      description
      completed
    }
  }
`;

const TOGGLE_TODO = gql`
  mutation CompletionTodo($id: ID!) {
    completionTodo(input: { id: $id }) {
      todo {
        id
        completed
      }
      errors
    }
  }
`;

const DELETE_TODO = gql`
  mutation DeleteTodo($id: ID!) {
    deleteTodo(input: { id: $id }) {
      success
      errors
    }
  }
`;

function TodoList() {
  const { loading, error, data } = useQuery(GET_TODOS);
  const [toggleTodo] = useMutation(TOGGLE_TODO);
  const [deleteTodo] = useMutation(DELETE_TODO, {
    refetchQueries: ["GetTodos"], // Refetch the list after deletion
  });

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  return (
    <ul style={{ listStyle: "none", padding: 0 }}>
      {data.todos.map((todo) => (
        <li
          key={todo.id}
          style={{
            marginBottom: "20px",
            padding: "10px",
            border: "1px solid #ddd",
            borderRadius: "4px",
          }}
        >
          <div>
            <strong>ID:</strong> {todo.id} <strong>Completed:</strong>{" "}
            <input
              type="checkbox"
              checked={todo.completed}
              onChange={() => toggleTodo({ variables: { id: todo.id } })}
            />{" "}
            <strong>Title:</strong>{" "}
            <span
              style={{
                textDecoration: todo.completed ? "line-through" : "none",
              }}
            >
              {todo.title}
            </span>
          </div>
          {todo.description && (
            <div>
              <strong>Description:</strong> {todo.description}
            </div>
          )}
          <button
            onClick={() => {
              deleteTodo({ variables: { id: todo.id } });
            }}
            style={{ marginLeft: "10px" }}
          >
            Delete
          </button>
        </li>
      ))}
    </ul>
  );
}

export default TodoList;
