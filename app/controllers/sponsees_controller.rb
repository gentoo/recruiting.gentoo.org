class SponseesController < ApplicationController
  def index
    @sponsees = current_user.sponsees.page params[:page]
  end

  def show
  end

  def destroy
    @sponsee = current_user.sponsees.find params[:id]
    current_user.sponsees.delete(@sponsee) if @sponsee.present?
    redirect_to action: :index
  end
end
