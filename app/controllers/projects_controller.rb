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
    @project.save
  end

  def destroy
  end

  def update
  end
  
end
