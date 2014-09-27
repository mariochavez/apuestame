class AddFieldsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :Name, :string
    add_column :organizations, :Address, :string
    add_column :organizations, :Description, :string
    add_column :organizations, :RFC, :string
    add_column :organizations, :Paypal, :string
  end
end
