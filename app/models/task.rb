class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 4000 }
  validates :deadline, presence: true
  validates :status, presence: true
  validate :defining_deadline_is_over
  validate :cheat_on_status

  private
  def defining_deadline_is_over
    if self.deadline < DateTime.now
      errors.add(:deadline, "の日付が作成日時の前に設定されています")
    end
  end

  def cheat_on_status
    if self.status != "未着手" && self.status != "着手中" && self.status != "完了"
      errors.add(:status, "の値が不正です")
    end
  end
end
