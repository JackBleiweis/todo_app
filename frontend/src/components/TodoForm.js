import { useState } from "react";
import { useMutation, gql } from "@apollo/client";

const CREATE_TODO = gql`
  mutation CreateTodo($title: String!, $description: String) {
    createTodo(input: { title: $title, description: $description }) {
      todo {
        id
        title
        description
        completed
      }
    }
  }
`;

function TodoForm() {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");

  const [createTodo] = useMutation(CREATE_TODO, {
    refetchQueries: ["GetTodos"], // Refetch the todos list after creating
  });

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!title.trim()) return; // Don't submit if title is empty

    createTodo({
      variables: {
        title,
        description: description || undefined, // Only send description if it has a value
      },
    });

    // Clear the form
    setTitle("");
    setDescription("");
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <input
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Todo title"
          required
        />
      </div>
      <div>
        <input
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="Description (optional)"
        />
      </div>
      <button type="submit">Add Todo</button>
    </form>
  );
}

export default TodoForm;
