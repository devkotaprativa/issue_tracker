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
  end
end
