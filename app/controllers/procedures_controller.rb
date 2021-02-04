class ProceduresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :manual_find, except: [:index, :show]
  before_action :procedure_find, only: [:edit, :update, :destroy]
  before_action :user_judge, except: [:index, :show]

  def new
    @procedure = Procedure.new
  end

  def create
    @procedure = @manual.procedures.new(procedure_params)
    url = params[:procedure][:image_url]
    converted_url = url.sub %r/data:((image|application)\/.{3,}),/, ""
    decoded_url = Base64.decode64(converted_url)
    filename = Time.zone.now.to_s + '.png'

    File.open("#{Rails.root}/tmp/images/#{filename}", "wb") do |f|
      f.write(decoded_url)
    end
    @procedure.image.attach(io: File.open("#{Rails.root}/tmp/images/#{filename}"), filename: filename)

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

  def destroy
    @procedure.destroy
    redirect_to manual_path(@manual)
  end

  private

  def procedure_params
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
end
