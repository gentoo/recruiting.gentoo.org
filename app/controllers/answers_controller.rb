class AnswersController < InheritedResources::Base
  load_and_authorize_resource

  before_filter :get_question, only: [:new, :edit, :update]

  def index
    authorize! :review, Answer
    @candidate = User.find params[:candidate_id] 
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

  def update
    @answer = @question.answers.find params[:id]
    @answer.update_attributes(params[:answer])
    @answer.submit! if @answer.rejected?
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
    @answer.accept!
    @answer.mentor_action!(current_user)
    #AnswerNotification.accept(@answer.user, @answer).deliver
    check_user_ready(@answer.user)
    redirect_to action: :review
  end

  def reject
    authorize! :review, Answer
    @answer = Answer.find params[:id]
    @answer.reject!
    @answer.mentor_action!(current_user)
    #AnswerNotification.reject(@answer.user, @answer).deliver
    redirect_to action: :review
  end

  private
  def check_user_ready(user)
    user.get_ready! if user.ready?
  end

  def get_question
    @question = Question.find(params[:question_id])
  end
end
