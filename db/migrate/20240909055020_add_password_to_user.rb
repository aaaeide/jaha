# frozen_string_literal: true

class AddPasswordToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string, null: false, default: ''
  end
end
