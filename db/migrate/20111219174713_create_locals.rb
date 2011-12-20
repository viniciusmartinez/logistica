class CreateLocals < ActiveRecord::Migration
  def change
    create_table :locals do |t|
      t.string :nome
      t.integer :numero
      t.integer :city_id
      t.integer :zone_id
      t.integer :detail_id

      t.timestamps
    end
  end
end


