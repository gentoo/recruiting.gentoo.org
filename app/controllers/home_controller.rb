class HomeController < ApplicationController
  def index
    @random_question = Question.random(1).first
  end
end
