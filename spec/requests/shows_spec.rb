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
    context 'without logged in user' do
      it 'renders a successful response' do
        get shows_url
        expect(response).to be_successful
      end
    end

    context 'with logged in user' do
      let(:current_user) { create(:user) }

      include_context 'with current_user logged in'

      it 'renders a successful response' do
        get shows_url
        expect(response).to be_successful
      end
    end

    context 'with logged in admin' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

      it 'renders a successful response' do
        get shows_url
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /show' do
    let(:show) { create(:show) }

    context 'without logged in user' do
      it 'renders a successful response' do
        get show_url(show)
        expect(response).to be_successful
      end
    end

    context 'with logged in user' do
      let(:current_user) { create(:user) }

      include_context 'with current_user logged in'

      it 'renders a successful response' do
        get show_url(show)
        expect(response).to be_successful
      end
    end

    context 'with logged in admin' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

      it 'renders a successful response' do
        get show_url(show)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /new' do
    context 'without logged in user' do
      it 'renders a 403 response' do
        get new_show_url
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in user' do
      let(:current_user) { create(:user) }

      include_context 'with current_user logged in'

      it 'renders a 403 response' do
        get new_show_url
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in admin' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

      it 'renders a successful response' do
        get new_show_url
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /edit' do
    let(:show) { create(:show) }

    context 'without logged in user' do
      it 'renders a 403 response' do
        get edit_show_url(show)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in user when user is a show host' do
      let(:current_user) { create(:user) }
      let(:show) { create(:show, user: current_user) }

      include_context 'with current_user logged in'

      it 'renders a successful response' do
        get edit_show_url(show)
        expect(response).to be_successful
      end
    end

    context 'with logged in user when user is not a show host' do
      let(:current_user) { create(:user) }

      include_context 'with current_user logged in'

      it 'renders a 403 response' do
        get edit_show_url(show)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in admin' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

      it 'renders a successful response' do
        get edit_show_url(show)
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /create' do
    context 'without logged in user' do
      it 'renders a 403 response' do
        post shows_url, params: { show: valid_attributes }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in user' do
      let(:current_user) { create(:user) }

      include_context 'with current_user logged in'

      it 'renders a 403 response' do
        post shows_url, params: { show: valid_attributes }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in admin and valid parameters' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

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

    context 'with logged in admin and invalid parameters' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

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
    let(:show) { create(:show) }

    context 'without logged in user' do
      it 'renders a 403 response' do
        patch show_url(show), params: { show: valid_attributes }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in user when the user is a show host' do
      let(:current_user) { create(:user) }
      let(:show) { create(:show, user: current_user) }
      let(:new_attributes) do
        { name: 'My new podcast', description: 'A podcast about nothing...' }
      end

      include_context 'with current_user logged in'

      it 'redirects to the show' do
        patch show_url(show), params: { show: new_attributes }
        show.reload
        expect(response).to redirect_to(show_url(show))
      end
    end

    context 'with logged in user when the user is not a show host' do
      let(:current_user) { create(:user) }
      let(:new_attributes) do
        { name: 'My new podcast', description: 'A podcast about nothing...' }
      end

      include_context 'with current_user logged in'

      it 'renders a 403 response' do
        patch show_url(show), params: { show: new_attributes }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in admin and valid parameters' do
      let(:current_user) { create(:user, :admin) }
      let(:new_attributes) do
        { name: 'My new podcast', description: 'A podcast about nothing...' }
      end

      include_context 'with current_user logged in'

      it 'updates the requested show' do
        patch show_url(show), params: { show: new_attributes }
        show.reload
        expect(show.name).to eq('My new podcast')
      end

      it 'redirects to the show' do
        patch show_url(show), params: { show: new_attributes }
        show.reload
        expect(response).to redirect_to(show_url(show))
      end
    end

    context 'with logged in admin and invalid parameters' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch show_url(show), params: { show: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context 'with logged in admin when adding a user' do
      let(:current_user) { create(:user, :admin) }
      let(:user) { create(:user) }

      include_context 'with current_user logged in'

      it 'adds a user to the show' do
        expect do
          patch show_url(show), params: { show: { new_host_user_id: user.id } }
        end.to change(show.users, :count).by(1)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:show) { create(:show) }

    context 'without logged in user' do
      it 'renders a 403 response' do
        delete show_url(show)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in user when the user is a show host' do
      let(:current_user) { create(:user) }
      let(:show) { create(:show, user: current_user) }

      include_context 'with current_user logged in'

      it 'renders a 403 response' do
        delete show_url(show)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in user when the user is not a show host' do
      let(:current_user) { create(:user) }

      include_context 'with current_user logged in'

      it 'renders a 403 response' do
        delete show_url(show)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'with logged in admin' do
      let(:current_user) { create(:user, :admin) }

      include_context 'with current_user logged in'

      it 'destroys the requested show' do
        delete show_url(show)
        expect(Show.find_by(id: show.id)).to be_nil
      end

      it 'redirects to the shows list' do
        delete show_url(show)
        expect(response).to redirect_to(shows_url)
      end
    end
  end
end
