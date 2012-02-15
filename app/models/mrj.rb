class Mrj < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.mrj'
   set_primary_key 'cod_objeto'
   
   default_scope :order => 'tip_mrj ASC'
   
   def self.por_zona(zona)
      where(:cod_objeto_zona => zona)
   end
   
   def self.por_municipio(municipio)
      where(:cod_objeto_municipio => municipio)
   end

   def self.por_dataeleicao(dataeleicao)
      where(:cod_objeto_dat_eleicao => dataeleicao)
   end
end
