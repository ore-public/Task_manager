class GroupsController < ApplicationController
  before_action :set_mygroup, only: %i[edit update destroy]
  before_action :logged_in_check
  before_action :correct_user_check, except: %i[index new create show]

  def index
    joinner = GroupUserRelation.where(user_id: current_user.id)
    @groups = Group.where(id: joinner).order(updated_at: :desc)
  end

  def show
    users = []
    joined = GroupUserRelation.where(group_id: params[:id])
    joined.each do |join|
      users << join.user_id
    end
    @group_tasks = Task.where(user_id: users)
                      .where(group_id: params[:id])
                      .page(params[:page]).per(20)
  end

  def new
    @mygroup = if params[:back]
                Group.new(group_params)
              else
                Group.new
              end
  end

  def create
    @mygroup = Group.new(group_params)
    @mygroup[:user_id] = current_user.id
    if @mygroup.save
      GroupUserRelation.create(user_id: current_user.id, group_id: @mygroup.id)
      redirect_to groups_path, notice: 'グループの作成に成功しました'
    else
      render :new
    end
  end

  def edit
    @mygroup = Group.find_by(id: params[:id])
  end

  def update
    if @mygroup.update(group_params)
      redirect_to @mygroup, notice: 'グループの編集に成功しました'
    else
      render :edit
    end
  end

  def destroy
    @mygroup.destroy
    redirect_to groups_path, notice: 'グループの削除に成功しました'
  end

  private
  def set_mygroup
    @mygroup = Group.find_by(id: params[:id])
  end

  def logged_in_check
    redirect_to new_session_path unless logged_in?
  end

  def correct_user_check
    redirect_to root_path if @mygroup.user_id != current_user.id
  end

  def group_params
    params.require(:group)
          .permit(:title, :info)
  end
end
