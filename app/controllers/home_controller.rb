class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.mentor? || current_user.recruiter?
        redirect_to review_answers_path
      elsif current_user.candidate?
        redirect_to unanswered_questions_path
      end
    end
    @random_question = Question.random(1).first
  end
end
