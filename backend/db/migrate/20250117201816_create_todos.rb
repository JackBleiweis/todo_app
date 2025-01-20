class CreateTodos < ActiveRecord::Migration[7.2]
  def change
    create_table :todos do |t|
      t.string :title, limit: 255
      t.string :description, limit: 1000
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
