class CreateCadNeighborhoods < ActiveRecord::Migration
  def change
    create_table :cad_neighborhoods do |t|
      t.string :cod_objeto
      t.integer :situacao
      t.string :nom_bairro
      t.string :cod_objeto_localidade
      t.string :cod_objeto_sub_localidade
      t.string :cod_objeto_bairro_ect
      t.string :tip_associacao
      t.string :origem

      t.timestamps
    end
  end
end
