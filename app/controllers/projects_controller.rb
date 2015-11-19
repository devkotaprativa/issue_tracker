class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:home]
  
  def index
    @assigned_projects = current_user.projects
    @projects = Project.where(:created_by => current_user.id)
    @current_user_projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
    @members = @project.users
    @issue = @project.issues.order(:status, created_at: :desc)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.start_date = params["project"][:start_date]
    @project.target_end_date = params["project"][:target_end_date]
    @project.final_end_date = params["project"][:final_end_date]
    @project.created_by = current_user.id
    if @project.save
      flash[:notice] = "Project successfully created"
    else
      flash[:notice] = "Project cannot be created"
    end
    redirect_to projects_path
  end

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
    project = Project.find(params[:id])
    users = project.users
    if users.present?
      members = Assignment.where(:project_id => project.id)
      members.destroy_all
    end
    if project.destroy
      flash[:notice] = "successfully deleted"
    else
      flash[:notice] = "Could not delete the project"
    end
    redirect_to projects_path
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Succeessfully Updated"
      redirect_to projects_path
    else
      flash[:alert] = "Sorry the update failed"
      redirect_to projects_path
    end
  end

  def show_members
    @users = User.all
    @project = Project.find(params[:project_id])
    @members = @project.users
  end

  def add_members
    ids = params[:user_ids]
    project_id = params[:project_id]
    if ids.present?
      ids.each do|id|
        if Assignment.where(:user_id => id, :project_id => project_id).blank?
           if Assignment.create(:user_id => id, :project_id => project_id)
            flash[:notice] = "Succeessfully added the members"
          else
            flash[:alert] = "Could not add the members"
          end
        else 
          flash[:alert] = "Slected member is already assigned to the project."
        end
      end
      redirect_to projects_path
    else
      flash[:notice] = "Please select at least one member"
      redirect_to show_members_projects_path(:project_id => project_id)
    end
  end

  def remove_members
    ids = params[:user_ids]
    project_id = params[:project_id]
    if ids.present?
      ids.each do |i|
        user = Assignment.where(:user_id => i, :project_id => project_id)
        if user.first.destroy
          flash[:notice] = "Succeessfully Removed!!!"
        else
          flash[:alert] = "Could not remove the user"
        end
        redirect_to show_members_projects_path(:project_id => project_id)
      end
    end
  end

  def home 
  end

  private
  def project_params
    params.require(:project).permit(:project_name, :start_date, :target_end_date, :final_end_date)
  end
  
end
