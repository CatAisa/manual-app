class ProceduresController < ApplicationController
  def new
    @manual = Manual.find(params[:manual_id])
    @procedure = Procedure.new
  end

  def create
    @manual = Manual.find(params[:manual_id])
    @procedure = @manual.procedures.new(procedure_params)
    if @procedure.save
      redirect_to manual_path(@manual)
    else
      render :new
    end
  end

  private

  def procedure_params
    params.require(:procedure).permit(:title, :image, :description).merge(user_id: current_user.id)
  end
end
