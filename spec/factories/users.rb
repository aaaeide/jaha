# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    name { Faker::TvShows::Seinfeld.character }
    email { Faker::Internet.email(name:) }
  end
end
