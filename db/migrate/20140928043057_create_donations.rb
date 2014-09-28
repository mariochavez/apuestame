class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.references :reward, index: true, null: false
      t.references :identity, index: true, null: false
      t.hstore :paypal_payment, null: false

      t.timestamps
    end
  end
end
