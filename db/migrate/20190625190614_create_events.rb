class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :reference_id
      t.string :event_type
      t.datetime :event_date
      t.string :uuid
      t.string :event_id
      t.json :body

      t.timestamps
    end
    add_index :events, :uuid, unique: true
    add_index :events, :event_id, unique: true
  end
end
