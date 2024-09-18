# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :current_user
  after_action :verify_pundit_authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def verify_pundit_authorization
    if action_name == 'index'
      verify_policy_scoped
    else
      verify_authorized
    end
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    session.delete(:user_id)
  end

  def user_not_authorized
    render(
      json: { error: 'You are not authorized to perform this action.' },
      status: :forbidden
    )
  end
end
