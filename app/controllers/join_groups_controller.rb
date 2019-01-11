class JoinGroupsController < ApplicationController
  def new
  end

  def create
    GroupUserRelation.create(group_id: params[:group_id], user_id: current_user.id)
    redirect_to groups_path, notice: "グループ#{Group.find_by(id: params[:group_id]).title}に参加しました"
  end

  def destroy
    group = Group.find_by(id: params[:id])
    unless group.user_id == current_user.id
      relation = GroupUserRelation.find_by(group_id: params[:id], user_id: current_user.id)
      relation.destroy
    else
      redirect_to groups_path, notice: "グループ作成者は離脱できません"
    end
    redirect_to groups_path, notice: "グループ#{group.title}から離脱しました"
  end
end
