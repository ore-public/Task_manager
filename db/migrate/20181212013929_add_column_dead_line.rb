# frozen_string_literal: true

class AddColumnDeadLine < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime, null: false, default: -> { 'NOW()' }
  end
end
