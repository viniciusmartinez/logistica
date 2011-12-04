class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.text :name
      
      t.datetime :due_at
      
      t.boolean :completed, :default => false
      t.integer :priority
      
      t.references :user
      t.references :contact

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
