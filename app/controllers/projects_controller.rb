class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @members = @project.users
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

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = "successfully deleted"
      redirect_to projects_path
    else
      flash[:notice] = "Could not delete the project"
      redirect_to projects_path
    end
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
    @project_id = params[:project_id]
  end

  def add_members
    ids = params[:user_ids]
    project_id = params[:project_id]
    if ids.present?
      ids.each do|id|
        if Assignment.where(:user_id => id, :project_id => project_id).blank?
           if Assignment.create(:user_id => id, :project_id => project_id)
            flash[:notice] = "Succeessfully added the members"
            redirect_to projects_path
          else
            flash[:alert] = "Could not add the members"
            redirect_to projects_path
          end
        else 
          flash[:alert] = "Slected member is already assigned to the project."
          redirect_to projects_path
        end
      end
    else
      flash[:notice] = "Please select at least one member"
      redirect_to projects_show_members_path
    end
  end

  def home
    
  end

  private
  def project_params
    params.require(:project).permit(:project_name, :start_date, :target_end_date, :final_end_date)
  end
  
end
