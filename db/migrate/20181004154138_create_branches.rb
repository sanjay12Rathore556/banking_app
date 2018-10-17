# frozen_string_literal: true

class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :address
      t.string :contact_no
      t.string :IFSC_code
      t.references :bank, index: true, foreign_key: true
      t.timestamps
    end
  end
end
