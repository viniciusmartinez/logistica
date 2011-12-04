class AddFavoriteToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :favorite, :boolean, :default => false
  end

  def self.down
    remove_column :contacts, :favorite
  end
end
