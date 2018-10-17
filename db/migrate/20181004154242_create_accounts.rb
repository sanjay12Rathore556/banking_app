# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :account_no
      t.float :balance
      t.string :account_type
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
