# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authorize_user

  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Du er nå logget inn.' and return
    end

    redirect_to login_url, alert: 'Ugyldig innlogging.'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Du er nå logget ut.'
  end

  private

  def authorize_user
    authorize :session
  end
end
