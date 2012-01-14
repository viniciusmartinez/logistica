class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.integer :numero
      t.integer :cad_id

      t.timestamps
    end
  end
end
