class RemoveDescriptionFromIdentities < ActiveRecord::Migration
  def change
    remove_column :identities, :description
  end
end
