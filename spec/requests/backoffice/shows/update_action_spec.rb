# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backoffice::Shows#update' do
  let(:valid_attributes) do
    { name: 'My new podcast', description: 'A podcast about nothing...' }
  end

  let(:invalid_attributes) do
    { name: nil, description: nil }
  end

  let(:current_user) { create(:user) }
  let!(:my_show) { create(:show, users: [current_user]) }
  let!(:your_show) { create(:show) }

  context 'without logged in user' do
    it 'redirects to login' do
      patch backoffice_show_url(your_show), params: { show: valid_attributes }
      expect(response).to redirect_to(login_url)
    end
  end

  context 'with logged in user without access to the show' do
    let(:current_user) { create(:user) }

    include_context 'with current_user logged in'

    it 'renders a 403' do
      patch backoffice_show_url(show), params: { show: valid_attributes }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not update the requested show' do
      patch backoffice_show_url(show), params: { show: valid_attributes }
      show.reload
      expect(show.name).to eq('My podcast')
    end
  end

  context 'with logged in user with access to the show' do
    let(:current_user) { create(:user) }

    include_context 'with current_user logged in'

    it 'updates the requested show' do
      patch backoffice_show_url(my_show), params: { show: valid_attributes }
      show.reload
      expect(show.name).to eq('My podcast')
    end

    it 'redirects to the show' do
      patch backoffice_show_url(my_show), params: { show: valid_attributes }
      expect(response).to redirect_to(backoffice_show_url(my_show))
    end
  end

  context 'with logged in admin' do
    let(:current_user) { create(:user, :admin) }

    include_context 'with current_user logged in'

    it 'updates the requested show' do
      patch backoffice_show_url(my_show), params: { show: valid_attributes }
      show.reload
      expect(show.name).to eq('Updated Show Name')
    end

    it 'redirects to the show' do
      patch backoffice_show_url(my_show), params: { show: valid_attributes }
      expect(response).to redirect_to(backoffice_show_url(my_show))
    end

    it 'renders a 422 with invalid parameters' do
      patch backoffice_show_url(my_show), params: { show: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'does not update the requested show with invalid parameters' do
      patch backoffice_show_url(my_show), params: { show: invalid_attributes }
      show.reload
      expect(show.name).to eq('My podcast')
    end
  end
end
