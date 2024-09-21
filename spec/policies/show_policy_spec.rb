# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShowPolicy, type: :policy do
  subject { described_class.new(user, show) }

  let(:show) { create(:show) }

  context 'when not logged in' do
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[new create edit update destroy]) }
  end

  context 'when logged in' do
    let(:user) { create(:user) }

    context 'when the user owns the show' do
      let(:show) { create(:show, user:) }

      it { is_expected.to permit_actions(%i[index show edit update]) }
    end

    context 'when the user does not own the show' do
      it { is_expected.to permit_actions(%i[index show]) }
    end
  end

  context 'when an admin' do
    let(:user) { create(:user, :admin) }

    it { is_expected.to permit_all_actions }
  end
end
