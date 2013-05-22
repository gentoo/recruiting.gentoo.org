class CandidatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :sponsor, User
    @candidates = User.candidates.page params[:page]
  end

  def show
    authorize! :sponsor, User
    @candidate = User.find_by_name params[:id]
  end

  def sponsor
    authorize! :sponsor, User
    @novice = User.find_by_name params[:id]
    current_user.recruit(@novice)
    redirect_to action: :index
  end

  def ready
    authorize! :promote, User
    @candidates = User.ready.page params[:page]
  end

  def recruit
    authorize! :promote, User
    @novice = User.find_by_name params[:id]
    @novice.promote!
    @mentors = @novice.mentors
    @mentors.each{|mentor| @novice.mentors.delete(mentor)}
    @novice.ready_user.delete
    @novice.save
    Notification.accept(current_user, @novice).deliver
    Notification.recruit(current_user, @novice, @mentors).deliver
    flash[:notice] = "#{@novice.name} is now a gentoo developer."
    redirect_to action: :ready
  end

  def ssh_key
    authorize! :sponsor, User
    @candidate = User.find_by_name params[:id]
    send_data @candidate.ssh_key, filename: "#{@candidate.name}.pub"
  end

  def gpg_key
    authorize! :sponsor, User
    @candidate = User.find_by_name params[:id]
    send_data @candidate.gpg_key, filename: "#{@candidate.name}.pub"
  end
end
