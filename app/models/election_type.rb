class ElectionType < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.tipo_eleicao'
   set_primary_key 'cod_objeto'
   
   #@@descritor = 'SITUACAO_LOCAL'
   #@@bom = ['ATIVO','BLOQUEADO']
   
   #scope :ordena, :order => "#{table_name}.num_local ASC"
end
