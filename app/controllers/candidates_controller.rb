class CandidatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :sponsor, User
    @candidates = User.candidates.page params[:page]
  end

  def show
    authorize! :sponsor, User
    @candidate = User.find_by name: params[:id]
  end

  def sponsor
    authorize! :sponsor, User
    @novice = User.find_by name: params[:id]
    current_user.recruit(@novice)
    redirect_to action: :index
  end

  def ready
    authorize! :promote, User
    @candidates = User.ready.page params[:page]
  end

  def developers
    @developers = ReadyUser.developers.page(params[:page]).map(&:user)
  end

  def arch_testers
    @testers = ReadyUser.arch_testers.page(params[:page]).map(&:user)
  end

  def staffers
    @staffers = ReadyUser.staffers.page(params[:page]).map(&:user)
  end

  # This is actually promote to mentor
  def recruit
    authorize! :promote, User
    @novice = User.find_by name: params[:id]
    # XXX The recruiter choose what post to assign the candidate
    # @novice.recuite! # => staffer
    @novice.promote! # => mentor
    @mentors = @novice.mentors
    @mentors.each{|mentor| @novice.mentors.delete(mentor)}
    # XXX only the one with the right group
    @novice.ready_users.delete_all
    @novice.save
    Notification.accept(current_user, @novice).deliver
    Notification.recruit(current_user, @novice, @mentors).deliver
    flash[:notice] = "#{@novice.name} is now a gentoo developer."
    redirect_to action: :ready
  end

  def ssh_key
    authorize! :sponsor, User
    @candidate = User.find_by name: params[:id]
    send_data @candidate.ssh_key, filename: "#{@candidate.name}-ssh.pub"
  end

  def gpg_key
    authorize! :sponsor, User
    @candidate = User.find_by name: params[:id]
    send_data @candidate.gpg_key, filename: "#{@candidate.name}-gpg.pub"
  end
end
