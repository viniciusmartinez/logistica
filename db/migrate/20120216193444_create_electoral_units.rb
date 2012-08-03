class CreateElectoralUnits < ActiveRecord::Migration
  def change
    create_table :electoral_units do |t|
      t.integer :id
      t.integer :election_id
      t.string :city_id
      t.string :zone_id

      t.timestamps
    end
  end
end
