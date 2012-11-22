class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    if ! params[:question_id].nil?
      @commentable = Question.find(params[:question_id])
    elsif ! params[:answer_id].nil?
      @commentable = Answer.find(params[:answer_id])
    else
      redirect_to root_path, notice: "Unknown comment"
    end
    @comment = @commentable.comments.create(params[:comment], user: current_user)
    @comment.save
    redirect_to @commentable
  end
end
