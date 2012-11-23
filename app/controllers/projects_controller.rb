class ProjectsController < ApplicationController
  def index
    @projects = Project.top_level.page params[:page]
  end
end
