require "test_helper"

class TodoTest < ActiveSupport::TestCase
    test "should not save todo without title" do
        todo = Todo.new
        assert_not todo.save, "Saved the todo without a title"
    end
    
    test "should save todo with title" do
        todo = Todo.new(title: "Test Todo")
        assert todo.save, "Could not save the todo with a title"
    end
    
    test "should not save todo with title longer than 255 characters" do
        todo = Todo.new(title: "a" * 256)
        assert_not todo.save, "Saved the todo with title too long"
    end
    
    test "should save todo with optional description" do
        todo = Todo.new(title: "Test Todo", description: "This is a test")
        assert todo.save, "Could not save todo with description"
    end
end
