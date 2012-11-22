class AnswersController < InheritedResources::Base
  load_and_authorize_resource

  before_filter :get_question, only: [:new]

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
    redirect_to action: :index
  end

  def reject
    authorize! :review, Answer
    @answer = Answer.find params[:id]
    @answer.reject!
    redirect_to action: :index
  end

  private
  def get_question
    @question = Question.find(params[:question_id])
  end
end
