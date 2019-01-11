# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path if @user.id != current_user.id
  end

  private

  def user_params
    params.require(:user)
          .permit(:name,
                  :email,
                  :password,
                  :password_confirmation)
  end
end
