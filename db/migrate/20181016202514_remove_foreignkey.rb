# frozen_string_literal: true

# Description/Explanation of Person class
class RemoveForeignkey < ActiveRecord::Migration[5.2]
  def change
    remove_reference :loans, :branch, index: true, foreign_key: true
  end
end
