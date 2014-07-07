class ReviewsController < ApplicationController
  def index
    authorize! :review, Answer
    @answers = Answer.reviewable(current_user).reviewed.page params[:page]
  end
end
