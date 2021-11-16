class UpdatesController < ApplicationController
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

    if @update.save
      redirect_to updates_path
    else
      render :new, status: :unprocessable_entity
    end
  end

private
  def update_params
    params.require(:update).permit(:project_id, :title, :body, :category, :publish_at, :deadline_at)
  end
end
