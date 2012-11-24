class QuestionsController < InheritedResources::Base
  load_and_authorize_resource

  def index
    @questions = Question.page params[:page]
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

  def assigned
    @questions = current_user.assigned_questions.page params[:page]
    render :index
  end

  def answered
    @questions = Question.answered_by(current_user).page params[:page]
    render :index
  end

  def unanswered
    @questions = Question.unanswered_by(current_user).page params[:page]
    render :index
  end
end
