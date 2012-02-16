class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.integer :id
      t.string :nome
      t.string :nome_abreviado
      t.string :election_date_id

      t.timestamps
    end
  end
end
