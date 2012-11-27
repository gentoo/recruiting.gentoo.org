class CommentsController < ApplicationController
  load_and_authorize_resource
  before_filter :get_commentable

  def create
    @comment = @commentable.comments.create(params[:comment])
    @comment.user = current_user
    @comment.save
    redirect_to @commentable
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.delete
    redirect_to @commentable
  end

  private
  def get_commentable
    if ! params[:question_id].nil?
      @commentable = Question.find(params[:question_id])
    elsif ! params[:answer_id].nil?
      @commentable = Answer.find(params[:answer_id])
    else
      redirect_to root_path, notice: "Unknown comment"
    end
  end
end
