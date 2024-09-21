# frozen_string_literal: true

module Backoffice
  class ShowPolicy < ApplicationPolicy
    def show?
      return false if user.nil?

      user.admin? || record.users.include?(user)
    end

    def index?
      user.present?
    end

    def create?
      user&.admin?
    end

    def new?
      create?
    end

    def update?
      return true if user&.admin?

      user.present? && record.users.include?(user)
    end

    def edit?
      update?
    end

    def destroy?
      user&.admin?
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        return scope.all if user&.admin?

        scope.joins(:users).where(users: { id: user.id })
      end
    end
  end
end
