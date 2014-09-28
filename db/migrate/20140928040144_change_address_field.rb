class ChangeAddressField < ActiveRecord::Migration
  def change
    remove_column :identities, :address
    add_column :campaigns, :address, :string, null: false
  end
end
