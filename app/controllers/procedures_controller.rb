class ProceduresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :manual_find, only: [:new, :create]
  before_action :user_judge, only: [:new, :create]

  def new
    @procedure = Procedure.new
  end

  def create
    @procedure = @manual.procedures.new(procedure_params)
    if @procedure.save
      redirect_to manual_path(@manual)
    else
      render :new
    end
  end

  def edit
    @manual = Manual.find(params[:manual_id])
    @procedure = @manual.procedures.find(params[:id])
  end

  def update
  end

  private

  def procedure_params
    params.require(:procedure).permit(:title, :image, :description).merge(user_id: current_user.id)
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @manual.user.id
  end
end
