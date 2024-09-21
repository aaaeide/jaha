# frozen_string_literal: true

RSpec.shared_context 'with logged in user', shared_context: :metadata do
  let(:current_user) { create(:user) }

  before do
    post login_url, params: { username: current_user.username, password: 'secret' }
  end
end

RSpec.shared_context 'with logged in admin', shared_context: :metadata do
  let(:current_user) { create(:user, :admin) }

  before do
    post login_url, params: { username: current_user.username, password: 'secret' }
  end
end
