class AddColumnPriorityToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :integer, default: 2
    add_index :tasks, :priority
  end
end
