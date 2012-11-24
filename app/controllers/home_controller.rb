class HomeController < ApplicationController
  def index
    @projects = Project.offset(rand(Project.count)).limit(5)
  end
end
