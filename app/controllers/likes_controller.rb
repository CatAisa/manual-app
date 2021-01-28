class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :manual_find, only: [:create, :destroy]
  before_action :user_judge, only: [:create, :destroy]

  def create
    if !current_user.already_liked?(@manual)
      Like.create(like_params)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user.already_liked?(@manual)
      @like = Like.find_by(user_id: current_user.id, manual_id: params[:manual_id])
      @like.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def like_params
    params.permit.merge(user_id: current_user.id, manual_id: params[:manual_id])
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end

  def user_judge
    redirect_to root_path if current_user.id == @manual.user.id
  end
end
