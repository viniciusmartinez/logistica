class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.integer :numero
      t.integer :cad_id
      t.integer :city_id
      t.integer :sincronizacao

      t.timestamps
    end
  end
end
