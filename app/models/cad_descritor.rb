class CadDescritor < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.dominios'
   set_primary_key 'cod_objeto'
   default_scope :order => 'nom_dominio ASC, valor ASC'
   
   def self.por_descritor(descritor)
      find_all_by_nom_dominio(descritor)
   end
   
   def self.por_descritor_valor(descritor, valor)
      where("nom_dominio = '#{descritor}' AND valor = ?", valor)
   end
   
   def self.descricao_por_descritor_valor(descritor, valor)
      por_descritor_valor(descritor, valor).first.descricao
   end
   
   def descricao
      self[:des_dominio].mb_chars.titleize
   end
   
   def descritor
      self[:nom_dominio]
   end     
   
   def self.por_descritor_descricao(descritor, descricao)
      where("nom_dominio = '#{descritor}'").where(:des_dominio => descricao)
   end

   def self.valor_por_descritor_descricao(descritor, descricao)
      por_descritor_descricao(descritor, descricao).first.valor
   end

   def self.valores_por_descritor_descricao(descritor, descricao)
      valores = []
      por_descritor_descricao(descritor, descricao).each {|descritor| valores << descritor.valor }
      return valores
   end
  
end

