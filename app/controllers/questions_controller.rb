class QuestionsController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.page params[:page]
  end

  def create
    @question = Question.new params[:question]
    @question.user = current_user
    if @question.save
      @question.approve! if current_user.admin?
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
