class Admin::UsersController < ApplicationController
  before_action :set_force_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.includes(:tasks)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー#{@user.name}を追加しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "管理者権限により#{@user.id}:#{@user.name}を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "管理者権限により#{@user.id}:#{@user.name}を削除しました"
  end

  private
  def set_force_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:name,
                  :email,
                  :password)
  end
end
