class CreateSuits < ActiveRecord::Migration
  def self.up
    create_table :suits do |t|
      t.string :entidade
      t.string :representante
      t.integer :protocol_id
      t.integer :status_decisao
      t.integer :status_atendimento

      t.timestamps
    end
  end

  def self.down
    drop_table :suits
  end
end
