class ManualsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    if user_signed_in?
      @user = current_user
    else
      @user = 0
    end
  end

  def new
    @manual = Manual.new
  end

  def create
    @manual = Manual.new(manual_params)
    if @manual.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @manual = Manual.find(params[:id])
  end

  private

  def manual_params
    params.require(:manual).permit(:title, :category_id, :description, :image).merge(user_id: current_user.id)
  end
end
