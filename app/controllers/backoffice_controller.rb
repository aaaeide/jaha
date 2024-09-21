# frozen_string_literal: true

class BackofficeController < ApplicationController
  before_action :authorize_user

  def show; end

  private

  def authorize_user
    authorize :backoffice
  rescue Pundit::NotAuthorizedError
    redirect_to login_url, alert: 'Du har ikke tilgang til denne siden.'
  end
end
