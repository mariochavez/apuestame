class CreateCampaigns < ActiveRecord::Migration
  def change
    execute 'CREATE EXTENSION hstore'

    create_table :campaigns do |t|
      t.references :organization, index: true
      t.string :name,       null: false
      t.decimal :amount,    null: false, precision: 5, scale: 2
      t.datetime :end_date, null: false
      t.text :description,  null: false
      t.hstore :tags

      t.timestamps
    end
  end
end
