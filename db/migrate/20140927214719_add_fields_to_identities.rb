class AddFieldsToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :name, :string, null: false
    add_column :identities, :address, :string, null: false
    add_column :identities, :description, :string, null: false
    add_column :identities, :rfc, :string
    add_column :identities, :paypal, :string, null: false
  end
end
