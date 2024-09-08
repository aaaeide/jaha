# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/shows' do
  # This should return the minimal set of attributes required to create a valid
  # Show. As you add validations to Show, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: 'My podcast', description: 'A podcast about everything.' }
  end

  let(:invalid_attributes) do
    { name: nil, description: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Show.create! valid_attributes
      get shows_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      show = Show.create! valid_attributes
      get show_url(show)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_show_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      show = Show.create! valid_attributes
      get edit_show_url(show)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Show' do
        expect do
          post shows_url, params: { show: valid_attributes }
        end.to change(Show, :count).by(1)
      end

      it 'redirects to the created show' do
        post shows_url, params: { show: valid_attributes }
        expect(response).to redirect_to(show_url(Show.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Show' do
        expect do
          post shows_url, params: { show: invalid_attributes }
        end.not_to change(Show, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post shows_url, params: { show: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'My new podcast', description: 'A podcast about nothing...' }
      end

      it 'updates the requested show' do
        show = Show.create! valid_attributes
        patch show_url(show), params: { show: new_attributes }
        show.reload
        expect(show.name).to eq('My new podcast')
      end

      it 'redirects to the show' do
        show = Show.create! valid_attributes
        patch show_url(show), params: { show: new_attributes }
        show.reload
        expect(response).to redirect_to(show_url(show))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        show = Show.create! valid_attributes
        patch show_url(show), params: { show: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context 'when adding a user' do
      let(:show) { create(:show) }
      let(:user) { create(:user) }
      let(:new_attributes) do
        { new_host_user_id: user.id }
      end

      it 'adds a user to the show' do
        expect do
          patch show_url(show), params: { show: new_attributes }
        end.to change(show.users, :count).by(1)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested show' do
      show = Show.create! valid_attributes
      expect do
        delete show_url(show)
      end.to change(Show, :count).by(-1)
    end

    it 'redirects to the shows list' do
      show = Show.create! valid_attributes
      delete show_url(show)
      expect(response).to redirect_to(shows_url)
    end
  end
end
