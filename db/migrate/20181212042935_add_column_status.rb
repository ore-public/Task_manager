# frozen_string_literal: true

class AddColumnStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string, null: false, default: '未着手'
  end
end
