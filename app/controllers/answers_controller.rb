class AnswersController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_filter :get_question, only: [:new, :edit, :update, :create] 
  def index
    authorize! :review, Answer
    @candidate = User.find_by_name params[:candidate_id] 
    if @candidate.candidate?
      @answers = @candidate.answers.page params[:page]
    else
      flash[:alert] = "This is not a candidate."
      redirect_to root_url
    end
  end

  def new
    authorize! :answer, Question
    @answer = current_user.answer_for(@question)
    if @answer
      render :edit
    else
      @answer = @question.answers.build(user: current_user)
    end
  end

  def create
    authorize! :answer, Question
    @answer = @question.answers.new(params[:answer])
    @answer.user = current_user
    if @answer.save
      AnswerNotification.update(current_user, @answer).deliver
    else
      render :new
    end
  end

  def update
    @answer = @question.answers.find params[:id]
    @answer.update_attributes(params[:answer])
    @answer.submit! if @answer.rejected?
    AnswerNotification.update(current_user, @answer).deliver
    redirect_to [@question, @answer]
  end

  def edit
    @answer = @question.answers.find params[:id]
    if current_user.candidate? && @answer.user != current_user
      flash[:alert] = "You cannot edit this answer."
      redirect_to @question
    end
  end

  def show
    @answer = Answer.find params[:id]
    @question = @answer.question
    if current_user.candidate? && @answer.user != current_user
      flash[:alert] = "You cannot view this answer."
      redirect_to @question
    end
  end

  def review
    @answers = current_user.answers_waiting_review.page params[:page]
  end

  def accept
    authorize! :review, Answer
    @answer = Answer.find params[:id]
    current_user.accept!(@answer)
    AnswerNotification.accept(current_user, @answer.user, @answer).deliver
    check_user_ready(@answer.user, @answer.group)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def reject
    authorize! :review, Answer
    @answer = Answer.find params[:id]
    current_user.reject!(@answer)
    AnswerNotification.reject(current_user, @answer.user, @answer).deliver
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
  def check_user_ready(user, group)
    if user.ready_for?(group)
      user.get_ready!(group)
      Notification.ready(user, group).deliver
    end
  end

  def get_question
    @question = Question.find(params[:question_id])
  end
end
