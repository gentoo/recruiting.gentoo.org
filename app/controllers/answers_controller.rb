class AnswersController < InheritedResources::Base
  load_and_authorize_resource

  before_filter :get_question, only: [:new, :edit]

  def new
    @answer = @question.answers.build(user: current_user)
  end

  def show
    @answer = Answer.find params[:id]
    @question = @answer.question
  end

  def review
    @answers = current_user.answers_waiting_review
  end

  def accept
    authorize! :review, Answer
    @answer = Answer.find params[:id]
    @answer.accept!
    Answer.accept(user, @answer).deliver
    check_user_ready(@answer.user)
    redirect_to action: :index
  end

  def reject
    authorize! :review, Answer
    @answer = Answer.find params[:id]
    @answer.reject!
    Answer.reject(user, @answer).deliver
    redirect_to action: :index
  end

  private
  def check_user_ready(user)
    user.get_ready! if user.ready?
  end

  def get_question
    @question = Question.find(params[:question_id])
  end
end
