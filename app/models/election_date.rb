class ElectionDate < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.data_de_eleicao'
   set_primary_key 'cod_objeto'
   
   default_scope :order => :dat_eleicao
   
   def data
      self[:dat_eleicao]
   end
end
