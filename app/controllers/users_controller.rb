class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :user_find, only: :show
  before_action :user_judge, only: :show

  def show
    @user = User.find(params[:id])
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_judge
    if current_user.id != @user.id
      redirect_to root_path
    end
  end
end
