class UsersController < ApplicationController
  before_action :login_judge, only: :show

  def show
    @user = User.find(params[:id])
  end

  private

  def login_judge
    if !user_signed_in?
      redirect_to root_path
    end
  end
end
