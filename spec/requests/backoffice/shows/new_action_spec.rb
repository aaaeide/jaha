# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backoffice::Shows#new' do
  before { get new_backoffice_show_url }

  context 'without logged in user' do
    it 'redirects to login' do
      expect(response).to redirect_to(login_url)
    end
  end

  context 'with logged in user' do
    let(:current_user) { create(:user) }

    include_context 'with current_user logged in'

    it 'renders a 403' do
      expect(response).to have_http_status(:forbidden)
    end
  end

  context 'with logged in admin' do
    let(:current_user) { create(:user, :admin) }

    include_context 'with current_user logged in'

    it 'renders a successful response' do
      expect(response).to have_http_status(:ok)
    end
  end
end
