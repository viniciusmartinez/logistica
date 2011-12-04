class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :name
      t.datetime :date
      
      t.references :user
      t.references :contact

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
