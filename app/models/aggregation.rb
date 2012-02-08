class Aggregation < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.historico_agregacao'
   set_primary_key 'cod_objeto'
   default_scope :order => 'tip_operacao ASC'
   
   scope :agregacao, where("tip_operacao = 1")
   scope :desagregacao, where("tip_operacao = 2")
   
   def self.por_zona(zona)
      where(:cod_objeto_zona => zona)
   end
   
   def self.por_municipio(municipio)
      where(:cod_objeto_munic => municipio)
   end

   def self.por_local(local)
      where(:cod_objeto_local => local)
   end
   
   def self.por_dataeleicao(dataeleicao)
      where(:cod_objeto_dat_eleicao => dataeleicao)
   end
end
