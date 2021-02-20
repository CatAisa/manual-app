class ProceduresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :manual_find, except: [:index, :show]
  before_action :procedure_find, only: [:edit, :update, :destroy]
  before_action :user_judge, except: [:index, :show]

  def new
    @procedure = Procedure.new
  end

  def create
    url = params[:procedure][:image_url]
    converted_url = url.sub %r/data:((image|application)\/.{3,}),/, ''

    if url.blank? || url == converted_url
      procedure = @manual.procedures.new(procedure_params)
    else
      procedure = @manual.procedures.new(procedure_params_no_image)
      procedure.image_attach(converted_url)
    end

    if procedure.save
      redirect_to manual_path(@manual)
    else
      @procedure = procedure
      render :new
    end
  end

  def edit
  end

  def update
    url = params[:procedure][:image_url]
    converted_url = url.sub %r/data:((image|application)\/.{3,}),/, ''

    if url.blank? || url == converted_url
      move_page(procedure_params)
    else
      move_page(procedure_params_no_image)
      @procedure.image_attach(converted_url)
    end
  end

  def destroy
    @procedure.destroy
    redirect_to manual_path(@manual)
  end

  private

  def procedure_params
    params.require(:procedure).permit(:title, :image, :description).merge(user_id: current_user.id)
  end

  def procedure_params_no_image
    params.require(:procedure).permit(:title, :description).merge(user_id: current_user.id)
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

  def move_page(params_type)
    if @procedure.update(params_type)
      redirect_to manual_path(@manual)
    else
      redirect_to edit_manual_procedure_path(@manual, @procedure)
    end
  end
end
