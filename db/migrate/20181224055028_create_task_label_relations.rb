# frozen_string_literal: true

class CreateTaskLabelRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :task_label_relations do |t|
      t.references :task, foregin_key: true
      t.references :label, foregin_key: true

      t.timestamps
    end
  end
end
