# frozen_string_literal: true

json.array! @shows, partial: 'shows/show', as: :show
