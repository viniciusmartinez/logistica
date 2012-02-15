class CreateMrjs < ActiveRecord::Migration
  def change
    create_table :mrjs do |t|
      t.string :cod_objeto
      t.integer :num_mesa
      t.string :cod_objeto_zona
      t.string :cod_objeto_municipio
      t.string :cod_objeto_dat_eleicao
      t.string :des_endereco
      t.string :des_observacao
      t.string :nom_local
      t.date :dat_criacao
      t.integer :tip_mrj

      t.timestamps
    end
  end
end
