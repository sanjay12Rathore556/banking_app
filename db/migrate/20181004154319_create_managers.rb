# frozen_string_literal: true

class CreateManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :managers do |t|
      t.string :name
      t.string :contact_no
      t.references :branch, index: true, foreign_key: true
      t.timestamps
    end
  end
end
