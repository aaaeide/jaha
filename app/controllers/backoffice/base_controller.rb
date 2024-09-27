# frozen_string_literal: true

module Backoffice
  class BaseController < ApplicationController
    rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

    def policy_scope(scope)
      super([:backoffice, scope])
    end

    def authorize(record, query = nil)
      super([:backoffice, record], query)
    end

    def handle_not_authorized
      case action_name
      when 'create', 'update', 'destroy'
        render status: :unauthorized and return if current_user.nil?
      when 'edit', 'new', 'index', 'show'
        redirect_to login_url and return if current_user.nil?
      end
      render status: :forbidden
    end
  end
end
