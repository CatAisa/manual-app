class UsersController < ApplicationController
  before_action :login_judge, only: :show

  def show
    @user = User.find(params[:id])
  end

  private

  def login_judge
    redirect_to root_path unless user_signed_in?
  end
end
