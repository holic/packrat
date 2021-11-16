class UpdatesController < ApplicationController
  before_action :find_update, except: [:index, :new, :create]
  before_action :verify_owner, only: [:edit, :update, :destroy]

  def index
    if @current_wallet
      @updates = Update.where(project_id: @current_wallet.follows.pluck(:project_id))
    else
      @updates = Update.all
    end
  end

  def show
    @project = Project.find_by(slug: params[:project_id])
    @update = Update.find(params[:id])
  end

  def new
    @update = Update.new
  end

  def create
    @update = Update.new(update_params)

    if (@current_wallet.managed_projects.where(id: @update.project.id).present? or @current_wallet.admin.present?) and @update.save
      redirect_to updates_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @update.update(update_params)
      redirect_to updates_path
    else
      render 'edit'
    end  
  end

  def destroy
    @update.destroy

    redirect_to updates_path
  end

private
  def find_update
    @update = Update.find(params[:id])
  end

  def update_params
    params.require(:update).permit(:project_id, :title, :body, :category, :publish_at, :deadline_at)
  end

  def verify_owner
    redirect_to updates_path unless @current_wallet.managed_projects.where(id: @update.project.id).present? or @current_wallet.admin.present?
  end
end
