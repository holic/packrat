class UpdatesController < ApplicationController
  def index
    @updates = Update.all
  end

  def show
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
