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
class Show < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :user_shows, dependent: :destroy
  has_many :users, through: :user_shows

  def add_host(user_id)
    user = User.find_by(id: user_id)

    if user
      users << user
      return true
    end

    false
  end
end
