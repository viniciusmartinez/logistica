class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.boolean :email_task_alert, :default => false
      t.boolean :email_birthday_alert, :default => false
      t.string :weather_location
      t.string :weather_location_name
      
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :preferences
  end
end
