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
    Notification.signup(current_user).deliver
    flash[:notice] = "Congratulations! You just applied for project #{@project.name}, our recruiters will get to you asap."
    redirect_to action: :applying
  end

  def applying
    @project = current_user.applying_project
  end

  def cancel_apply
    current_user.update_attribute :applying_project, nil
    current_user.reject!
    flash[:notice] = "You have canceled you application, now you can apply to another project."
    redirect_to action: :index
  end
end
