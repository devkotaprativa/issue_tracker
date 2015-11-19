class IssuesController < ApplicationController
  def index
  end

  def show
    @issue = Issue.find(params[:id])
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
    project = Project.find(params[:project_id])
    issue = Issue.find(params[:id])
    users = issue.users
    if users.present?
      members = UserIssue.where(:issue_id => issue.id)
      members.destroy_all
    end
    if issue.destroy
      flash[:notice] = "Succeessfully Deleted"
    else
      flash[:notice] = "Could not Delete the Isse"
    end
    redirect_to project_path(project.id)
  end

  def create
    @project = Project.find(params[:project_id])
    @issue = Issue.new(set_params)
    @issue.project_id = @project.id
    @issue.status = 0
    if @issue.save
      flash[:notice] = "Issue successfully created"
    else
      flash[:notice] = "Issue was not created"
    end
    redirect_to project_path(@project.id)
  end

  def show_members
    @project = Project.find(params[:project_id])
    @users = @project.users
    @issue = Issue.find(params[:issue_id])
    @members = @issue.users
  end

  def add_members
    ids = params[:user_ids]
    project_id = params[:project_id]
    @issue = Issue.find(params[:issue_id])
    if ids.present?
      ids.each do|id|
        if UserIssue.where(:user_id => id, :issue_id => @issue.id).blank?
           if UserIssue.create(:user_id => id, :issue_id => @issue.id)
            flash[:notice] = "Succeessfully added the members"
          else
            flash[:alert] = "Could not add the members"
          end
        else 
          flash[:alert] = "Slected member is already assigned to the project."
        end
      end
      redirect_to project_path(project_id)
    else
      flash[:notice] = "Please select at least one member"
      redirect_to project_issue_issues_show_members_path(project_id, @issue.id)
    end
  end

  def remove_members
    ids = params[:user_ids]
    @issue = Issue.find(params[:issue_id])
    project_id = params[:project_id]
    if ids.present?
      ids.each do |i|
        user = UserIssue.where(:user_id => i, :issue_id => @issue.id)
        if user.first.destroy
          flash[:notice] = "Succeessfully Removed"
        else
          flash[:notice] = "Could not Delete the user"
        end
      end
    else
     flash[:notice] = "Please select atleast one member"
    end
     redirect_to project_issue_issues_show_members_path(project_id, @issue.id)
  end

  def complete
    @issue = Issue.find(params[:issue_id])
    @issue.completed!
    redirect_to project_path(@issue.project_id)  
  end

  def processing
    @issue = Issue.find(params[:issue_id])
    @issue.processing!
    redirect_to project_path(@issue.project_id)
  end

  def reopen
    @issue = Issue.find(params[:issue_id])
    @issue.pending!
    redirect_to project_path(@issue.project_id)
  end

  private
  def set_params
    params.require(:issue).permit(:title, :description, :deadline, :priority, :status)
  end
end
