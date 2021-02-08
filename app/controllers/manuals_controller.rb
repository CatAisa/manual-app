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
    converted_url = url.sub %r/data:((image|application)\/.{3,}),/, ""

    if url.blank? || url == converted_url
      manual = Manual.new(manual_params)
    else
      manual = Manual.new(manual_params_no_image)
      decoded_url = Base64.decode64(converted_url)
      filename = Time.zone.now.to_s + '.png'

      if Rails.env == "development"
        # Local environment
        manual.image_attach_local(manual, decoded_url, filename)
      elsif Rails.env == "production"
        # Production environment
        manual.image_attach_production(manual, decoded_url, filename)
      end
    end

    if manual.save
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
    manual = @manual
    url = params[:manual][:image_url]
    converted_url = url.sub %r/data:((image|application)\/.{3,}),/, ""

    if url.blank? || url == converted_url
      if manual.update(manual_params)
        redirect_to manual_path(@manual)
      else
        render :edit
      end
    else
      if manual.update(manual_params_no_image)
        redirect_to manual_path(@manual)
      else
        render :edit
      end
      decoded_url = Base64.decode64(converted_url)
      filename = Time.zone.now.to_s + '.png'

      if Rails.env == "development"
        # Local environment
        manual.image_attach_local(manual, decoded_url, filename)
      elsif Rails.env == "production"
        # Production environment
        manual.image_attach_production(manual, decoded_url, filename)
      end
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
end
