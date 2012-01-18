class City < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.localidade'
   set_primary_key 'cod_objeto'
   
   default_scope :order => "#{table_name}.nom_localidade ASC"
   scope :ordena, :order => "#{table_name}.nom_localidade ASC"
   
   has_many :zones, :through => :places
   
   has_many :places,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_localidade

   scope :mt, where("cod_objeto_uf" => "18")
   scope :ativos, where("situacao = ? AND nom_localidade != ?",1,"OUTROS MATO GROSSO")
   scope :bons, mt.ativos
   
   scope :outros, where("situacao = ? AND nom_localidade = ?",1,"OUTROS MATO GROSSO")
   scope :desativados, where("situacao = ?",2)
   
   def numero
      self[:cod_localidade_tse]
   end
   
   def nome
      self[:nom_localidade].mb_chars.titleize
   end
   
   def id
      self[:cod_objeto]
   end
   
   def self.nome(id)
      find(id).nome
   end
end
