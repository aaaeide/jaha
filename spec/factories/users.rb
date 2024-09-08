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
FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    name { Faker::TvShows::Seinfeld.character }
    email { Faker::Internet.email(name:) }
  end
end
