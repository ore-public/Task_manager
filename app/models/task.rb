class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 4000 }
  validates :deadline, presence: true
  validate :defining_deadline_is_over

  private
  def defining_deadline_is_over
    if self.deadline < DateTime.now
      errors.add(:deadline, "の日付が作成日時の前に設定されています")
    end
  end
end
