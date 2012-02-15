class EleCandidate < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["eleicao"]
   set_table_name 'admeleicao.candidato'
   set_primary_keys 'cd_eleicao', 'nr_cand'
end
