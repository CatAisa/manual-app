class UsersController < ApplicationController
  before_action :login_judge, only: :show

  def show
  end

  private

  def login_judge
    if !user_signed_in?
      redirect_to root_path
    end
  end
end
