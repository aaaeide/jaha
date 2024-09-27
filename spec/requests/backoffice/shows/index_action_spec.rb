# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backoffice::Shows#index' do
  let(:current_user) { create(:user) }

  let!(:my_show) { create(:show, name: 'my pod!', users: [current_user]) }
  let!(:your_show) { create(:show, name: 'not my pod!') }

  context 'without logged in user' do
    it 'redirects to login' do
      get backoffice_shows_url
      expect(response).to redirect_to(login_url)
    end
  end

  context 'with logged in user' do
    include_context 'with current_user logged in'

    before { get backoffice_shows_url }

    it 'renders a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes my show in resolved scope' do
      expect(response.body).to include(my_show.name)
    end
  end

  context 'with logged in admin' do
    let(:current_user) { create(:user, :admin) }

    include_context 'with current_user logged in'

    before { get backoffice_shows_url }

    it 'renders a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes my show in resolved scope' do
      expect(response.body).to include(my_show.name)
    end

    it 'includes your show in resolved scope' do
      expect(response.body).to include(your_show.name)
    end
  end
end
