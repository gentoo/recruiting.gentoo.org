class ProjectsController < ApplicationController
  before_filter :authenticate_user!, only: [:apply, :mine]
  def index
    @projects = Project.top_level.page params[:page]
  end

  def subprojects
    @projects = Project.subprojects(params[:parent_id])
    render json: @projects
  end

  def apply
    authorize! :apply, Project
    @project = Project.find params[:id]
    current_user.apply_project(@project)
    flash[:notice] = "Congratulations! You just applied for project #{@project.name}, our recruiters will get to you asap."
    redirect_to action: :index
  end

  def mine
    @project = current_user.applied_project
  end
end
