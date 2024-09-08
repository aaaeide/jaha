# frozen_string_literal: true

class CreateShows < ActiveRecord::Migration[7.1]
  def change
    create_table :shows do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description

      t.timestamps
    end
  end
end
