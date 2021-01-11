class ManualsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :manual_find, only: [:show, :edit, :update]
  before_action :user_judge, only: [:show, :edit, :update]

  def index
    @user = if user_signed_in?
              current_user
            else
              0
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
    @procedures = @manual.procedures.includes(:user)
  end

  def edit
    binding.pry
  end

  def update
    if @manual.update(manual_params)
      redirect_to manual_path(@manual)
    else
      render :edit
    end
  end

  private

  def manual_params
    params.require(:manual).permit(:title, :category_id, :description, :image).merge(user_id: current_user.id)
  end

  def manual_find
    @manual = Manual.find(params[:id])
  end

  def user_judge
    if current_user.id != @manual.user.id
      redirect_to root_path
    end
  end
end
