class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.references :campaign, null: false
      t.decimal :amount, null: false, precision: 8, scale: 2
      t.string :description, null: false

      t.timestamps
    end
  end
end
