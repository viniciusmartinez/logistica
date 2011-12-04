class AddAvatarToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :avatar, :string
  end

  def self.down
    remove_column :contacts, :avatar
  end
end
