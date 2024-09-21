# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BackofficePolicy, type: :policy do
  subject { described_class.new(user, :admin_dashboard) }

  context 'when user is an admin' do
    let(:user) { create(:user, :admin) }

    it { is_expected.to permit_actions(%i[show]) }
  end

  context 'when user is not an admin' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions(%i[show]) }
  end

  context 'when user is not logged in' do
    let(:user) { nil }

    it { is_expected.to forbid_actions(%i[show]) }
  end
end
