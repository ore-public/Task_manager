class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 4000 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validate :defining_deadline_is_over, on: :create
  validate :cheat_on_status
  # validate :cheat_on_priority

  enum priority: {low: 0, middle: 1, high: 2}

  def self.search(tasks)
      search = tasks[:search]
      status_s = tasks[:status_s]
      priority = tasks[:priority]
    if status_s == "" && search == "" && priority == ""
      all
    elsif search && status_s == ""
      where(['title LIKE ?', "%#{search}%"])
    elsif status_s && search
      where(['title LIKE ?', "%#{search}%"]).where(status: "#{status_s}")
    else
      all
    end
  end

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

  # def cheat_on_priority
  #   if self.priority < 0 && self.priority > 2
  #     errors.add(:priority, "の値が不正です")
  #   end
  # end
end
