class ProceduresController < ApplicationController
  def new
    @manual = Manual.find(params[:manual_id])
  end

  def create
  end
end
