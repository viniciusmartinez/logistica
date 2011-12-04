class AddNameNormalizedToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :name_normalized, :string
  end

  def self.down
    remove_column :contacts, :name_normalized
  end
end
