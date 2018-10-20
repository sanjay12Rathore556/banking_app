# frozen_string_literal: true

# Description/Explanation of Person class
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :father_name
      t.string :mother_name
      t.string :address
      t.string :contact_no
      t.integer :age
      t.references :branch, index: true, foreign_key: true
      t.timestamps
    end
  end
end
