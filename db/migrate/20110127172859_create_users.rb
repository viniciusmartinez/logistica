class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :name
      t.string :crypted_password  
      t.string :password_salt  
      t.string :persistence_token
      t.string :address
      t.integer :address_number
      t.string :address_extra
      t.string :neighborhood
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :gender, :limit => 1
      t.string :phone
      t.string :mobile
      t.boolean :admin, :default => false
      
      t.integer :login_count
      t.integer :failed_login_count
      t.string :current_login_at
      t.string :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
