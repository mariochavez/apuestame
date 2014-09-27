class AddFieldsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :name, :string, null: false
    add_column :organizations, :address, :string, null: false
    add_column :organizations, :description, :string, null: false
    add_column :organizations, :rfc, :string, null: false
    add_column :organizations, :paypal, :string, null: false
  end
end
