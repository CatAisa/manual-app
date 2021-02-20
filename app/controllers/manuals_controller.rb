class ManualsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :manual_find, only: [:show, :edit, :update, :destroy]
  before_action :user_judge, only: [:edit, :update, :destroy]
  before_action :show_user_judge, only: :show

  def index
    @releases = Release.includes(:user).order(created_at: 'DESC')
  end

  def new
    @manual = Manual.new
  end

  def create
    url = params[:manual][:image_url]
    converted_url = url.sub %r/data:((image|application)\/.{3,}),/, ''

    if url.blank? || url == converted_url
      manual = Manual.new(manual_params)
    else
      manual = Manual.new(manual_params_no_image)
      manual.image_attach(converted_url)
    end

    if manual.save
      @user = current_user
      redirect_to user_path(@user)
    else
      @manual = manual
      render :new
    end
  end

  def show
    @procedures = @manual.procedures.includes(:user)
    @comment = Comment.new
    @release = Release.new
    @review = Review.new
  end

  def edit
  end

  def update
    url = params[:manual][:image_url]
    converted_url = url.sub %r/data:((image|application)\/.{3,}),/, ''

    if url.blank? || url == converted_url
      move_page(manual_params)
    else
      move_page(manual_params_no_image)
      @manual.image_attach(converted_url)
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

  def manual_params_no_image
    params.require(:manual).permit(:title, :category_id, :description).merge(user_id: current_user.id)
  end

  def manual_find
    @manual = Manual.find(params[:id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @manual.user.id
  end

  def show_user_judge
    redirect_to root_path if @manual.release.blank? && (current_user.id != @manual.user.id)
  end

  def move_page(params_type)
    if @manual.update(params_type)
      redirect_to manual_path(@manual)
    else
      redirect_to edit_manual_path(@manual)
    end
  end
end
