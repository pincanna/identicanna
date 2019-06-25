class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :verification_code, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :line1, null: false
      t.string :line2, null: true
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :letter_id
      t.string :letter_status
      t.json :letter

      t.timestamps
    end
    add_index :addresses, :verification_code, unique: true
    add_index :addresses, :letter_id, unique: true
  end
end
