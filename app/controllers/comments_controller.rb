class CommentsController < ApplicationController
  before_action :manual_find, only: [:create, :destroy]

  def create
    @procedure = @manual.procedures.find(params[:procedure_id])
    @comment = @procedure.comments.new(comment_params)
    @comment[:manual_id] = @manual.id
    if @comment.save
      redirect_to manual_path(@manual)
    else
      @procedures = @manual.procedures.includes(:user)
      render 'manuals/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to manual_path(@manual)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :manual_id, :procedure_id).merge(user_id: current_user.id)
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end
end
