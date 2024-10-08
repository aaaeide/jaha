# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default(FALSE), not null
#  email           :string           not null
#  name            :string
#  password_digest :string           default(""), not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }

  it { is_expected.to validate_presence_of(:username) }
  it { expect(user).to validate_uniqueness_of(:username) }
  it { is_expected.to validate_presence_of(:email) }
end
