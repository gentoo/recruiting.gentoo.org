class QuestionsController < InheritedResources::Base
  load_and_authorize_resource

  def index
    @questions = current_user.questions
  end

  def create
    @question = Question.new params[:question]
    @question.user = current_user
    @question.approved = current_user.admin?
    if @question.save
      render :show
    else
      render :new
    end
  end

  def show
    @question = Question.includes(:comments).find params[:id]
  end

  def answered
    @questions = Question.answered_by(current_user)
  end

  def unanswered
    @questions = Question.unanswered_by(current_user)
  end
end
