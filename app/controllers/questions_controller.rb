class QuestionsController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @group = Group.find params[:group_id]
    @questions = @group.questions.page(params[:page])
  end

  def create
    @question = Question.new params[:question]
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
    @questions = current_user.questions.page params[:page]
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
