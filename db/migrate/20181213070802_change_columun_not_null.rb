# frozen_string_literal: true

class ChangeColumunNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :priority, :integer, null: false
  end
end
