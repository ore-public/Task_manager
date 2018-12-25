class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 4000 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validate :defining_deadline_is_over, on: :create
  validate :cheat_on_status
  # validate :cheat_on_priority

  belongs_to :user
  has_many :task_label_relations, dependent: :destroy
  has_many :stuck_labels, through: :task_label_relations, source: :label
  accepts_nested_attributes_for :task_label_relations, allow_destroy: true


  enum priority: {low: 0, middle: 1, high: 2}

  scope :deadline_order, -> tasks do
    if tasks[:deadline_c] == "期日昇順"
      order(deadline: :asc)
    elsif tasks[:deadline_c] == "期日降順"
      order(deadline: :desc)
    else
      order(created_at: :desc)
    end
  end
  scope :title_search, -> (tasks) { where(['title LIKE ?', "%#{tasks[:search]}%"]) if tasks[:search].present? }
  scope :status_choise, -> (tasks) { where(status: "#{tasks[:status_s]}") if tasks[:status_s].present? }
  scope :priority_choise, -> (tasks) { where(priority: "#{tasks[:priority]}") if tasks[:priority].present?}
  scope :priority_order, -> (tasks) { order(priority: :desc) if tasks[:priority_s] == "優先度順" }


  def label_maker(label_text, task_int)
    scaned_labels = label_text.scan(/.+/)
    scaned_labels.each do |la|
      Label.create(name: la, task_id: task_int)
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


  #datebase limitで対応可能！
  # def cheat_on_priority
  #   if self.priority < 0 && self.priority > 2
  #     errors.add(:priority, "の値が不正です")
  #   end
  # end
end
