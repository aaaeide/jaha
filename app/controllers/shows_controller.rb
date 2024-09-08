# frozen_string_literal: true

class ShowsController < ApplicationController
  before_action :set_show, only: %i[show edit update destroy]

  def index
    @shows = Show.all
  end

  def show; end

  def new
    @show = Show.new
  end

  def edit; end

  def create
    @show = Show.new(show_params)

    if @show.save
      redirect_to show_url(@show), notice: 'Show was successfully created.'
      return
    end

    render :new, status: :unprocessable_entity
  end

  def update
    if @show.update(show_params.except(:new_host_user_id))
      handle_new_host
      redirect_to show_url(@show), notice: 'Show was successfully updated.'

      return
    end

    render :edit, status: :unprocessable_entity
  end

  def destroy
    @show.destroy!

    redirect_to shows_url, notice: 'Show was successfully destroyed.'
  end

  private

  def handle_new_host
    return if show_params[:new_host_user_id].blank?
    return if @show.add_host(show_params[:new_host_user_id])

    flash.now[:alert] = "Could not find user with ID #{show_params[:new_host_user_id]}."
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_show
    @show = Show.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def show_params
    params.require(:show).permit(:name, :description, :new_host_user_id)
  end
end
