class GroupUserRelation < ApplicationRecord
  validates :user_id, :uniqueness => {:scope => :group_id}

  belongs_to :group
  belongs_to :user

end
