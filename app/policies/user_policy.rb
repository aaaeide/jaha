# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && user.admin?
  end

  def new?
    create?
  end

  def update?
    return true if user.present? && user.admin?

    user == record
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
