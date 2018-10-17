# frozen_string_literal: true

class RemoveForeignkey < ActiveRecord::Migration[5.2]
  def change
    remove_reference :loans, :branch, index: true, foreign_key: true
  end
end
