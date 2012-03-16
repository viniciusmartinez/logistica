class CadNeighborhood < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.bairro'
   set_primary_key 'cod_objeto'
   default_scope :order => 'nom_bairro ASC, situacao ASC'
   
   has_many :places,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_bairro
   
   #scope :mt, where("cod_objeto_uf" => "18")
   scope :ativos, where(:situacao => 1)
   #scope :bons, mt.ativos
      
   
   def nome
      self[:nom_bairro].mb_chars.titleize
   end
   
   def id
      self[:cod_objeto]
   end
end
