class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :email
      t.string :password_hash
      t.string :password_digest

      t.timestamps
    end
  end
end
