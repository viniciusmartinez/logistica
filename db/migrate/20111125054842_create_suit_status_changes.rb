class CreateSuitStatusChanges < ActiveRecord::Migration
  def self.up
    create_table :suit_status_changes do |t|
      t.datetime :momento
      t.integer :status
      t.text :comentario
      t.integer :suit_id

      t.timestamps
    end
  end

  def self.down
    drop_table :suit_status_changes
  end
end
