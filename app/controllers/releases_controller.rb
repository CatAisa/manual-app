class ReleasesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :manual_find, only: [:create, :destroy]
  before_action :user_judge, only: [:create, :destroy]

  def create
    if @manual.release.blank?
      Release.create(release_params)
      redirect_to manual_path(@manual)
    else
      redirect_to root_path
    end
  end

  def destroy
    @release = Release.find(params[:id])
    @release.destroy
    redirect_to manual_path(@manual)
  end

  private

  def release_params
    params.permit.merge(user_id: current_user.id, manual_id: params[:manual_id])
  end

  def manual_find
    @manual = Manual.find(params[:manual_id])
  end

  def user_judge
    redirect_to root_path if current_user.id != @manual.user.id
  end
end
