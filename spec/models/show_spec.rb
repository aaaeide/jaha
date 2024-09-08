# frozen_string_literal: true

# == Schema Information
#
# Table name: shows
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_shows_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Show do
  let(:show) { create(:show) }

  it { is_expected.to validate_presence_of(:name) }
  it { expect(show).to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:user_shows).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:user_shows) }
end
