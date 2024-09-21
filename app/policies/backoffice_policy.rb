# frozen_string_literal: true

class BackofficePolicy < ApplicationPolicy
  def show?
    user.present?
  end
end
