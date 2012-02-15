class CreateEleCandidates < ActiveRecord::Migration
  def change
    create_table :ele_candidates do |t|
      t.integer :cd_eleicao
      t.integer :nr_cand

      t.timestamps
    end
  end
end
