class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :manual_find, only: [:create, :destroy]
  before_action :comment_find, only: :destroy
  before_action :user_judge, only: :destroy

  def create
    @procedure = @manual.procedures.find(params[:procedure_id])
    @comment = @procedure.comments.new(comment_params)
    render json: { model: @comment, user: current_user } if @comment.save
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :procedure_id).merge(user_id: current_user.id,
                                                                   manual_id: params[:manual_id])
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end

  def comment_find
    if Comment.exists?(id: params[:id])
      @comment = Comment.find(params[:id])
    else
      redirect_to manual_path(@manual)
    end
  end

  def user_judge
    redirect_to root_path if current_user.id != @comment.user.id && current_user.id != @manual.user.id
  end
end
