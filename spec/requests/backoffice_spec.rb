# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backoffice' do
  describe 'GET /show' do
    context 'when user is an admin' do
      include_context 'with logged in admin'

      it 'renders a successful response' do
        get backoffice_url
        expect(response).to be_successful
      end
    end

    context 'when user is not an admin' do
      include_context 'with logged in user'

      it 'renders a successful response' do
        get backoffice_url
        expect(response).to be_successful
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get backoffice_url
        expect(response).to redirect_to(login_url)
      end
    end
  end
end