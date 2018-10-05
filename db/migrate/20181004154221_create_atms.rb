class CreateAtms < ActiveRecord::Migration[5.2]
  def change
    create_table :atms do |t|
      t.string :name
      t.string :address
      t.references :bank, index: true, foreign_key: true 	
      t.timestamps
    end
  end
end
