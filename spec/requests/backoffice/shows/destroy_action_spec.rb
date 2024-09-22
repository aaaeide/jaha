# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backoffice::Shows#destroy' do
  let(:valid_attributes) do
    { name: 'My podcast', description: 'A podcast about everything.' }
  end

  let(:invalid_attributes) do
    { name: nil, description: nil }
  end

  let!(:my_show) { create(:show, users: [current_user]) }
  let!(:your_show) { create(:show) }

  context 'without logged in user' do
    it 'redirects to login' do
      delete backoffice_show_url(your_show)
      expect(response).to redirect_to(login_url)
    end
  end

  context 'with logged in user' do
    let(:current_user) { create(:user) }

    include_context 'with current_user logged in'

    it 'renders a 403' do
      delete backoffice_show_url(my_show)
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not destroy the requested show' do
      expect do
        delete backoffice_show_url(my_show)
      end.not_to change(Show, :count)
    end
  end

  context 'with logged in admin' do
    let(:current_user) { create(:user, :admin) }

    include_context 'with current_user logged in'

    it 'destroys the requested show' do
      expect do
        delete backoffice_show_url(my_show)
      end.to change(Show, :count).by(-1)
    end

    it 'redirects to the shows index' do
      delete backoffice_show_url(my_show)
      expect(response).to redirect_to(backoffice_shows_url)
    end
  end
end
