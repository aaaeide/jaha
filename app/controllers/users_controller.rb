# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    unless @user.save
      render :new, status: :unprocessable_entity
      return
    end

    session[:user_id] = @user.id
    redirect_to user_url(@user), notice: 'User was successfully created.'
  end

  def update
    unless @user.update(user_params)
      render :edit, status: :unprocessable_entity
      return
    end

    redirect_to user_url(@user), notice: 'User was successfully updated.'
  end

  def destroy
    @user.destroy!

    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :name, :password, :password_confirmation)
  end
end
