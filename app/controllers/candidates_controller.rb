class CandidatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @candidates = User.candidates.page params[:page]
  end

  def show
    @candidate = User.find params[:id]
  end

  def sponsor
    authorize! :sponsor, User
    @novice = User.find params[:id]
    current_user.recruit(@novice)
    redirect_to action: :index
  end

  def ready
    authorize! :promote, User
    @candidates = User.ready.page params[:page]
  end

  def recruit
    authorize! :promote, User
    @novice = User.find params[:id]
    @novice.promote!
    @mentors = @novice.mentors
    @mentors.each{|mentor| @novice.mentors.delete(mentor)}
    @novice.ready_user.delete
    @novice.save
    # TODO 
    # Send email notification to the user
    flash[:notice] = "#{@novice.name} is now a gentoo developer."
    redirect_to action: :ready
  end
end
