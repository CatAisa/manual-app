class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :manual_find, only: [:create, :destroy]
  before_action :review_find, only: :destroy
  before_action :user_judge, only: :destroy

  def create
    @review = @manual.reviews.new(review_params)
    render json: { model: @review, user: current_user } if @review.save
  end

  def destroy
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:content).merge(user_id: current_user.id)
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end

  def review_find
    @review = Review.find(params[:id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @review.user.id && current_user.id != @manual.user.id
  end
end
