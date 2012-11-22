class AnswersController < InheritedResources::Base
  load_and_authorize_resource

  before_filter :get_question

  def new
    @answer = @question.answers.build(user: current_user)
  end

  private
  def get_question
    @question = current_user.questions.find(params[:question_id])
  end
end
