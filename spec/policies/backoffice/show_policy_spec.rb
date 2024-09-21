# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Backoffice::ShowPolicy, type: :policy do
  subject { described_class.new(user, show) }

  let(:my_show) { create(:show, user:) }
  let(:your_show) { create(:show) }

  let(:resolved_scope) do
    described_class::Scope.new(user, Show.all).resolve
  end

  context 'when not logged in' do
    let(:user) { nil }
    let(:show) { create(:show) }

    it { is_expected.to forbid_all_actions }
  end

  context 'when logged in' do
    let(:user) { create(:user) }

    context 'when accessing my show' do
      let(:show) { my_show }

      it { is_expected.to permit_only_actions(%i[index show edit update]) }

      it 'includes my show in resolved scope' do
        expect(resolved_scope).to include(show)
      end
    end

    context 'when accessing your show' do
      let(:show) { your_show }

      it { is_expected.to permit_only_actions(%i[index]) }

      it 'does not include your show in resolved scope' do
        expect(resolved_scope).not_to include(show)
      end
    end
  end

  context 'when an admin' do
    let(:user) { create(:user, :admin) }

    context 'when accessing my show' do
      let(:show) { my_show }

      it { is_expected.to permit_all_actions }

      it 'includes my show in resolved scope' do
        expect(resolved_scope).to include(show)
      end
    end

    context 'when accessing your show' do
      let(:show) { your_show }

      it { is_expected.to permit_all_actions }

      it 'includes your show in resolved scope' do
        expect(resolved_scope).to include(show)
      end
    end
  end
end
