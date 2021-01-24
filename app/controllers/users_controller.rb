class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :user_find, only: :show
  before_action :user_judge, only: :show

  def show
    @release = Release.new
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @user.id
  end
end
