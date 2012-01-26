class CreateAggregationHistories < ActiveRecord::Migration
  def change
    create_table :aggregation_histories do |t|
      t.string :cod_objeto
      t.string :cod_objeto_zona
      t.string :cod_objeto_munic
      t.string :cod_objeto_local
      t.string :cod_objeto_secao_principal
      t.string :cod_objeto_secao_agregada
      t.integer :tip_operacao
      t.date :dat_operacao
      t.string :cod_operador
      t.integer :qtd_aptos_principal
      t.integer :qtd_aptos_agregada
      t.string :cod_objeto_dat_eleicao

      t.timestamps
    end
  end
end
