class AddFieldsToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :amount, :decimal, null: false, precision: 8, scale: 2
  end
end
