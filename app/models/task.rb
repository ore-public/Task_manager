class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 4000 }
  validates :deadline, presence: true

  def defining_deadline_is_over?
    errors.add(:deadline, "の日付が作成日時の前に設定されています")
    self.deadline < self.created_at
  end
end
