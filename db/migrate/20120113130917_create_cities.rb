class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :nome
      t.integer :numero
      t.integer :cad_id
      t.integer :zone_id

      t.timestamps
    end
  end
end
