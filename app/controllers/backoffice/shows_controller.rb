# frozen_string_literal: true

module Backoffice
  class ShowsController < Backoffice::BaseController
    before_action :set_show, only: %i[show edit update destroy]
    before_action :authorize_user

    def index
      @shows = policy_scope(Show)
    end

    def show; end

    def new
      @show = Show.new
    end

    def edit; end

    def create
      @show = Show.new(show_params)

      if @show.save
        redirect_to backoffice_show_url(@show), notice: 'Show was successfully created.'
        return
      end

      render :new, status: :unprocessable_entity
    end

    def update
      if @show.update(show_params.except(:new_host_user_id))
        handle_new_host
        redirect_to backoffice_show_url(@show), notice: 'Show was successfully updated.'

        return
      end

      render :edit, status: :unprocessable_entity
    end

    def destroy
      @show.destroy!

      redirect_to backoffice_shows_url, notice: 'Show was successfully destroyed.'
    end

    private

    def set_show
      @show = Show.find(params[:id])
    end

    def show_params
      params.require(:show).permit(:name, :description, :new_host_user_id)
    end

    def authorize_user
      authorize @show || Show
    end

    def handle_new_host
      return if show_params[:new_host_user_id].blank?
      return if @show.add_host(show_params[:new_host_user_id])

      flash.now[:alert] = "Could not find user with ID #{show_params[:new_host_user_id]}."
    end
  end
end