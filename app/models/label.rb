class Label < ApplicationRecord
  validates :name, presence: true, length: { maximum: 12 }
  has_many :task_label_relations, dependent: :destroy
  has_many :stuck_tasks, through: :task_label_relations
  # 今回の場合は tasks で意味が分かるし別名はつけなくていいと思う
end
