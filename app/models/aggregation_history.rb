class AggregationHistory < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.historico_agregacao'
   set_primary_key 'cod_objeto'
   default_scope :order => 'tip_operacao ASC'
   
   scope :agregacao, where("tip_operacao = 1")
   scope :desagregacao, where("tip_operacao = 2")
   
   def self.por_zona_municipio_local(zona,municipio,local)
      where(:cod_objeto_zona => zona).where(:cod_objeto_munic => municipio).where(:cod_objeto_local => local)
   end
   
   def self.por_zona_municipio(zona,municipio)
      where(:cod_objeto_zona => zona).where(:cod_objeto_munic => municipio)
   end

   def self.por_dataeleicao_zona_municipio(dataeleicao,zona,municipio)
      where(:cod_objeto_dat_eleicao => dataeleicao).where(:cod_objeto_zona => zona).where(:cod_objeto_munic => municipio)
   end

   def self.por_dataeleicao(dataeleicao)
      agregacao.where(:cod_objeto_dat_eleicao => dataeleicao)
   end

end
