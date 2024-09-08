# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  name       :string
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:email) }
end
