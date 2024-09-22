# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions' do
  describe 'should render login route' do
    it 'returns http success' do
      get login_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    let(:user) { create(:user) }

    it 'logs in with correct password' do
      post login_url, params: {
        username: user.username,
        password: 'secret'
      }

      expect(response).to redirect_to(root_url)
    end

    it 'does not log in with incorrect password' do
      post login_url, params: {
        username: user.username,
        password: 'wrong'
      }

      expect(response).to redirect_to(login_url)
    end
  end

  describe 'DELETE /logout' do
    let(:current_user) { create(:user) }

    include_context 'with current_user logged in'

    it 'logs out' do
      delete logout_url
      expect(session[:user_id]).to be_nil
    end

    it 'redirects on logout' do
      delete logout_url
      expect(response).to redirect_to(root_url)
    end
  end
end
