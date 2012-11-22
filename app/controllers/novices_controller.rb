class NovicesController < ApplicationController
  def index
    @novices = User.novices
  end

  def sponsor
    @novice = User.find params[:id]
    current_user.recruit(@novice)
    redirect_to action: :index
  end

  def ready
    @novices = User.ready
  end
end
