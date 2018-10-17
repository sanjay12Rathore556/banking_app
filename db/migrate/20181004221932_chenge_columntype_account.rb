# frozen_string_literal: true

class ChengeColumntypeAccount < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :account_no, :string
    change_column :accounts, :balance, :float
  end
end
