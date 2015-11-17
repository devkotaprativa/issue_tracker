class IssuesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @project = Project.find(params[:project_id])
    @issue = Issue.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
    @project = Project.find(params[:project_id])
    @issue = Issue.new(set_params)
    @issue.project_id = @project.id
    if @issue.save
      flash[:notice] = "Issue successfully created"
      redirect_to project_path(@project.id)
    else
      flash[:notice] = "Issue was not created"
      redirect_to project_path(@project.id)
    end
  end

  private
  def set_params
    params.require(:issue).permit(:title, :description, :deadline, :priority, :status)
  end
end
