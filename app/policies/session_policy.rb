# session_policy.rb
# frozen_string_literal: true

SessionPolicy = Struct.new(:user, :record) do
  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    true
  end
end
