class TtbSessionsController < ApplicationController


  def new
    render 'new'
  end

  def create
    store_ttb_password(params[:ttb_password])
    redirect_to signin_path, notice: "Please sign in."
  end

  private

  

end
