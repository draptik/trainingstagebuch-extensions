class TtbSessionsController < ApplicationController

  # GET
  def new
    render 'new'
  end

  # POST
  def create
    store_ttb_password(params[:ttb_password])
    redirect_to import_sports_user_path(current_user), notice: "OK, got your ttb password."
  end

  private

  

end
