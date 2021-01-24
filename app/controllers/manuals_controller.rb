class ManualsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :manual_find, only: [:show, :edit, :update, :destroy]
  before_action :user_judge, only: [:edit, :update, :destroy]
  before_action :show_user_judge, only: :show

  def index
    @release = Release.new
    @releases = Release.includes(:user)
  end

  def new
    @manual = Manual.new
  end

  def create
    @manual = Manual.new(manual_params)
    if @manual.save
      @user = current_user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @procedures = @manual.procedures.includes(:user)
    @comment = Comment.new
    @release = Release.new
  end

  def edit
  end

  def update
    if @manual.update(manual_params)
      redirect_to manual_path(@manual)
    else
      render :edit
    end
  end

  def destroy
    @manual.destroy
    @user = current_user
    redirect_to user_path(@user)
  end

  private

  def manual_params
    params.require(:manual).permit(:title, :category_id, :description, :image).merge(user_id: current_user.id)
  end

  def manual_find
    @manual = Manual.find(params[:id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @manual.user.id
  end

  def show_user_judge
    if @manual.release.blank?
      redirect_to root_path if current_user.id != @manual.user.id
    end
  end
end
