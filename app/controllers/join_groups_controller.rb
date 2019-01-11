class JoinGroupsController < ApplicationController
  def new
  end

  def create
    GroupUserRelation.create(group_id: params[:group_id], user_id: current_user.id)
    redirect_to groups_path, notice: "グループ#{Group.find_by(id: params[:group_id]).title}に参加しました"
  end

  def destroy
  end
end
