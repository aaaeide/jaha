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
FactoryBot.define do
  factory :show do
    name { "The #{Faker::Appliance.brand} Pod" }
    description do
      "We talk about everything, from #{Faker::Appliance.equipment}s to #{Faker::Appliance.equipment}s."
    end

    # Optionally create a user or associate one if provided
    after(:create) do |show, evaluator|
      show.users << (evaluator.user || create(:user))
    end

    # Allow passing in a user when calling the factory
    transient do
      user { nil }
    end
  end
end
