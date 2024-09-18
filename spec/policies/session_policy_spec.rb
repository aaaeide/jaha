# session_policy_spec.rb
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionPolicy, type: :policy do
  subject { described_class.new(user, :session) }

  let(:user) { create(:user) }

  it { is_expected.to permit_actions(%i[new create destroy]) }
end
