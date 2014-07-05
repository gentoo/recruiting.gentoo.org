class SponseesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @sponsees = current_user.sponsees.page params[:page]
  end

  def show
  end

  def destroy
    authorize! :sponsor, User
    @sponsee = current_user.sponsees.find_by name: params[:id]
    current_user.sponsees.delete(@sponsee) if @sponsee.present?
    redirect_to action: :index
  end
end
