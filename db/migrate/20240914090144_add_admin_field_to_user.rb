# frozen_string_literal: true

class AddAdminFieldToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
