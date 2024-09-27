# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backoffice::Shows#create' do
  let(:valid_attributes) do
    { name: 'My podcast', description: 'A podcast about everything.' }
  end

  let(:invalid_attributes) do
    { name: nil, description: nil }
  end

  context 'without logged in user' do
    it 'renders a 401' do
      post backoffice_shows_url, params: { show: valid_attributes }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'with logged in user' do
    let(:current_user) { create(:user) }

    include_context 'with current_user logged in'

    it 'renders a 403' do
      post backoffice_shows_url, params: { show: valid_attributes }
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'with logged in admin and valid parameters' do
    let(:current_user) { create(:user, :admin) }

    include_context 'with current_user logged in'

    it 'creates a new Show' do
      expect do
        post backoffice_shows_url, params: { show: valid_attributes }
      end.to change(Show, :count).by(1)
    end

    it 'redirects to the created show' do
      post backoffice_shows_url, params: { show: valid_attributes }
      expect(response).to redirect_to(backoffice_show_url(Show.last))
    end
  end

  context 'with logged in admin and invalid parameters' do
    let(:current_user) { create(:user, :admin) }

    include_context 'with current_user logged in'

    it 'does not create a new Show' do
      expect do
        post backoffice_shows_url, params: { show: invalid_attributes }
      end.not_to change(Show, :count)
    end

    it 'renders a 422' do
      post backoffice_shows_url, params: { show: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
