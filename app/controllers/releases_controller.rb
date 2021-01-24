class ReleasesController < ApplicationController

  def create
    @manual = Manual.find(params[:manual_id])
    if @manual.release.blank?
      Release.create(release_params)
      redirect_to manual_path(@manual)
    else
      redirect_to root_path
    end
  end

  private

  def release_params
    params.permit(:release).permit().merge(user_id: current_user.id, manual_id: params[:manual_id])
  end
end
