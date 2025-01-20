import { ApolloClient, InMemoryCache, ApolloProvider } from "@apollo/client";
import TodoList from "./components/TodoList";
import TodoForm from "./components/TodoForm";
import "./App.css";

const client = new ApolloClient({
  uri: "http://localhost:3000/graphql",
  cache: new InMemoryCache(),
  credentials: "omit",
});

function App() {
  return (
    <ApolloProvider client={client}>
      <div className="App">
        <h1>Todo App</h1>
        <TodoForm />
        <TodoList />
      </div>
    </ApolloProvider>
  );
}

export default App;
