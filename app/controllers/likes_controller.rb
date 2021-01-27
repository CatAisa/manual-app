class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    Like.create(like_params)
    redirect_to root_path
  end

  private

  def like_params
    params.permit.merge(user_id: current_user.id, manual_id: params[:manual_id])
  end
end
