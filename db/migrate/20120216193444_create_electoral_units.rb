class CreateElectoralUnits < ActiveRecord::Migration
  def change
    create_table :electoral_units do |t|
      t.integer :id
      t.integer :election_id
      t.integer :city_id
      t.integer :zone_id

      t.timestamps
    end
  end
end
