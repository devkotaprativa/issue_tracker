class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    
    @project = Project.new(project_params)
    @project.start_date = params["project"][:start_date]
    @project.target_end_date = params["project"][:target_end_date]
    @project.final_end_date = params["project"][:final_end_date]
    if @project.save
      flash[:notice] = "Project successfully created"
      redirect_to projects_path
    else
      flash[:notice] = "Project cannot be created"
      redirect_to projects_path
    end
  end

  def destroy
  end

  def update
  end

  private
  def project_params
    params.require(:project).permit(:project_name, :start_date, :target_end_date, :final_end_date)
  end
  
end
