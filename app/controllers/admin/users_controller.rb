# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :admin_check
  before_action :set_force_user, only: %i[show edit update destroy]

  def index
    @users = User.all.includes(:tasks).order(id: 'asc')
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー：#{@user.name}を追加しました"
    else
      render 'new'
    end
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @user.update!(user_params)
      User.find_by!(admin: true)
    end
    redirect_to admin_users_path, notice: "管理者権限により#{@user.id}:#{@user.name}を編集しました"
  rescue StandardError
    redirect_to admin_users_path, notice: '編集を実行すると管理者が不在になります'
  end

  def destroy
    ActiveRecord::Base.transaction do
      @user.destroy!
      User.find_by!(admin: true)
    end
    redirect_to admin_users_path, notice: "管理者権限により#{@user.id}:#{@user.name}を削除しました"
  rescue StandardError
    redirect_to admin_users_path, notice: '削除を実行すると管理者が不在になります'
  end

  private

  def set_force_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:name,
                  :email,
                  :password,
                  :admin)
  end

  def admin_check
    raise Forbidden unless logged_in? && admin?
  end
end
