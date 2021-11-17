class ProjectsController < ApplicationController
  before_action :get_project, except: [:index]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new  
  end

  def follow
    if @current_wallet.follows.find_or_create_by(project: @project) 
      redirect_to project_path(@project.slug)
    end
  end

  def unfollow
    follow = @current_wallet.follows.find_by(project: @project)

    follow.destroy if follow.present?

    redirect_to project_path(@project.slug)
  end

private
  def get_project
    @project = Project.find_by(slug: params[:id])
  end
end
