class ManualsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
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

  private
  def manual_params
    params.require(:manual).permit(:title, :category_id, :description).merge(user_id: current_user.id)
  end
end
