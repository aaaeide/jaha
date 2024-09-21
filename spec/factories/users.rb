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
FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    name { Faker::TvShows::Seinfeld.character }
    email { Faker::Internet.email(name:) }
    password { 'secret' }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
