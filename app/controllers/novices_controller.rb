class NovicesController < ApplicationController
  def index
    @novices = User.awaiting_review
  end

  def sponsor
    @novice = User.find params[:id]
    current_user.recruit(@novice)
    redirect_to action: :index
  end

  def ready
    @novices = User.ready
  end

  def recruit
    @novice = User.find params[:id]
    @novice.promote!
    @novice.ready_user.delete
    @novice.projects << @novice.applied_project
    @novice.applied_project = nil
    @novice.save
    # TODO 
    # Send email notification to the user
    flash[:notice] = "#{@novice.name} is now a gentoo developer."
    redirect_to action: :ready
  end
end
