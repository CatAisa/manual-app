class ProceduresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :manual_find, except: [:index, :show]
  before_action :procedure_find, only: [:edit, :update]
  before_action :user_judge, except: [:index, :show]

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
  end

  def update
    if @procedure.update(procedure_params)
      redirect_to manual_path(@manual)
    else
      render :edit
    end
  end

  private

  def procedure_params
    params.require(:procedure).permit(:title, :image, :description).merge(user_id: current_user.id)
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end

  def procedure_find
    @procedure = @manual.procedures.find(params[:id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @manual.user.id
  end
end
