class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.string :loan_type
      t.integer :amount
      t.integer :interest
      t.integer :time_period
      t.references :branch, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true 
      t.timestamps
    end
  end
end
