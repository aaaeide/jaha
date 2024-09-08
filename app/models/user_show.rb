# frozen_string_literal: true

# == Schema Information
#
# Table name: user_shows
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  show_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_shows_on_show_id  (show_id)
#  index_user_shows_on_user_id  (user_id)
#
# Foreign Keys
#
#  show_id  (show_id => shows.id)
#  user_id  (user_id => users.id)
#
class UserShow < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :show, dependent: :destroy
end
