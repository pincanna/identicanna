class AddActivatedToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :activated, :boolean, default: false
  end
end
