class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :info, length: { maximum: 500 }

  belongs_to :user
  has_many :group_user_relations, dependent: :destroy
  has_many :joinner, through: :group_user_relations, source: :user
end
