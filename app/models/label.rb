class Label < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 }
  has_many :task_label_relations, dependent: :destroy
  has_many :stuck_tasks, through: :task_label_relations, source: :task
end
