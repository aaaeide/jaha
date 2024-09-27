# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backoffice::Shows#show' do
  let(:current_user) { create(:user) }

  let!(:my_show) { create(:show, name: 'my pod!', users: [current_user]) }
  let!(:your_show) { create(:show, name: 'not my pod!') }

  context 'without logged in user' do
    it 'redirects to login' do
      get backoffice_show_url(your_show)
      expect(response).to redirect_to(login_url)
    end
  end

  context 'with logged in user' do
    include_context 'with current_user logged in'

    it 'renders a successful response' do
      get backoffice_show_url(my_show)
      expect(response).to have_http_status(:ok)
    end

    it 'shows my show' do
      get backoffice_show_url(my_show)
      expect(response.body).to include(my_show.name)
    end

    it 'does not show your show' do
      get backoffice_show_url(your_show)
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'with logged in admin' do
    let(:current_user) { create(:user, :admin) }

    include_context 'with current_user logged in'

    it 'renders a successful response' do
      get backoffice_show_url(my_show)
      expect(response).to have_http_status(:ok)
    end

    it 'shows my show' do
      get backoffice_show_url(my_show)
      expect(response.body).to include(my_show.name)
    end

    it 'shows your show' do
      get backoffice_show_url(your_show)
      expect(response.body).to include(your_show.name)
    end
  end
end
