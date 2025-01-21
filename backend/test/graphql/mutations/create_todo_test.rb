require "test_helper"

class Mutations::CreateTodoTest < ActiveSupport::TestCase
  def perform(args = {})
    TodoAppSchema.execute(
      query: mutation_string,
      variables: { "input" => args },
      context: {}
    ).to_h
  end

  def mutation_string
    <<~GQL
      mutation CreateTodo($input: CreateTodoInput!) {
        createTodo(input: $input) {
          todo {
            id
            title
            description
            completed
          }
        }
      }
    GQL
  end

  test "creates a todo with valid attributes" do
    result = perform(
      "title" => "Test Todo",
      "description" => "Test description",
      "completed" => false
    )

    assert_nil result["errors"]
    todo_data = result.dig("data", "createTodo", "todo")
    assert todo_data
    assert_equal "Test Todo", todo_data["title"]
    assert_equal "Test description", todo_data["description"]
    assert_equal false, todo_data["completed"]
  end

  test "fails without title" do
    result = perform(
      "description" => "Test description",
      "completed" => false
    )

    assert result["errors"]
    assert_nil result["data"]
  end

  test "fails with title longer than 255 characters" do
    result = perform(
      "title" => "a" * 256,
      "description" => "Test description",
      "completed" => false
    )

    assert_nil result.dig("data", "createTodo")
    assert result["errors"]
  end
end
