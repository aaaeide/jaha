# frozen_string_literal: true

class ShowPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
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

    user.present? && record.users.include?(user)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
