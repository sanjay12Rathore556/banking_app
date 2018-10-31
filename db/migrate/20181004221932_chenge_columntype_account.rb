# frozen_string_literal: true

# Description/Explanation of Person class
class ChengeColumntypeAccount < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :account_no, :string
    change_column :accounts, :balance, :float
  end
end
