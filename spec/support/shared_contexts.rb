# frozen_string_literal: true

RSpec.shared_context 'with current_user logged in', shared_context: :metadata do
  before do
    post login_url, params: { username: current_user.username, password: 'secret' }
  end
end
