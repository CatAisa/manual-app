class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :manual_find, only: [:create, :destroy]
  before_action :comment_find, only: :destroy
  before_action :user_judge, only: :destroy

  def create
    @procedure = @manual.procedures.find(params[:procedure_id])
    @comment = @procedure.comments.new(comment_params)
    # @comment[:manual_id] = @manual.id
    if @comment.save
      render json: { comment: @comment, user: current_user }
    else
      @procedures = @manual.procedures.includes(:user)
      render 'manuals/show'
    end
    # if @comment.save
    #   redirect_to manual_path(@manual)
    # else
    #   @procedures = @manual.procedures.includes(:user)
    #   render 'manuals/show'
    # end
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :manual_id, :procedure_id).merge(user_id: current_user.id,
                                                                               manual_id: params[:manual_id])
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end

  def comment_find
    @comment = Comment.find(params[:id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @comment.user.id && current_user.id != @manual.user.id
  end
end
