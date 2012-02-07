class City < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.localidade'
   set_primary_key 'cod_objeto'
   
   default_scope :order => "#{table_name}.nom_localidade ASC"
   scope :ordena, :order => "#{table_name}.nom_localidade ASC"
   
   has_many :zones, :through => :places, :uniq => true
   
   has_many :places,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_localidade

   scope :mt, where("cod_objeto_uf" => "18")
   scope :ativos, where(:situacao => 1).where("nom_localidade != ?","OUTROS MATO GROSSO") #colocar dois CadDescritor.valores_por_descritor_descricoes
   scope :bons, mt.ativos
   
   scope :outros, where(:situacao => 1).where(:nom_localidade => "OUTROS MATO GROSSO") #colocar dois CadDescritor.valores_por_descritor_descricoes
   scope :desativados, where(:situacao => 2) #colocar um CadDescritor.valores_por_descritor_descricoes
      
   def numero
      self[:cod_localidade_tse]
   end
   
   def nome
      self[:nom_localidade].mb_chars.titleize
   end
   
   def id
      self[:cod_objeto]
   end
end
