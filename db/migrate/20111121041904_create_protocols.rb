class CreateProtocols < ActiveRecord::Migration
  def self.up
    create_table :protocols do |t|
      t.integer :numero
      t.date :data

      t.timestamps
    end
  end

  def self.down
    drop_table :protocols
  end
end
