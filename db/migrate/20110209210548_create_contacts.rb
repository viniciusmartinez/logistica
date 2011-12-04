class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :occupation
      t.text :address
      t.string :zip_code
      t.string :city
      t.string :state
      t.date :birthday
      t.text :description
      t.references :user
      t.integer :rank, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
