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
    @issue.status = 0
    if @issue.save
      flash[:notice] = "Issue successfully created"
      redirect_to project_path(@project.id)
    else
      flash[:notice] = "Issue was not created"
      redirect_to project_path(@project.id)
    end
  end

  def show_members
    @project = Project.find(params[:project_id])
    @users = @project.users
    @issue_id = params[:issue_id]
  end

  def add_members
    ids = params[:user_ids]
    issue_id = params[:issue_id]
    project_id = params[:project_id]
    if ids.present?
      ids.each do|id|
        binding.pry
        if UserIssue.where(:user_id => id, :issue_id => issue_id).blank?
           if UserIssue.create(:user_id => id, :issue_id => issue_id)
            flash[:notice] = "Succeessfully added the members"
            redirect_to project_path(project_id)
          else
            flash[:alert] = "Could not add the members"
            redirect_to project_path(project_id)
          end
        else 
          flash[:alert] = "Slected member is already assigned to the project."
          redirect_to project_path(project_id)
        end
      end
    else
      flash[:notice] = "Please select at least one member"
      redirect_to project_issues_show_members_path
    end
  end

  private
  def set_params
    params.require(:issue).permit(:title, :description, :deadline, :priority, :status)
  end
end
