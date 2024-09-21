# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(user, user_record) }

  let(:user_record) { create(:user) }

  let(:resolved_scope) do
    described_class::Scope.new(user, User.all).resolve
  end

  context 'when not logged in' do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context 'when logged in' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context 'when the user is the record' do
    let(:user) { user_record }

    it { is_expected.to permit_actions(%i[index show update edit]) }
    it { is_expected.to forbid_actions(%i[new create destroy]) }
  end

  context 'when an admin' do
    let(:user) { create(:user, :admin) }

    it { is_expected.to permit_all_actions }
  end
end
