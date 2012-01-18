class Zone < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.zona'
   set_primary_key 'cod_objeto'
   
   default_scope :order => "#{table_name}.num_zona ASC"
   
   has_many :cities, :through => :places
   
   has_many :places,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_zona
   
   scope :mt, where("cod_objeto_uf" => "18")
   
   def nome
      "ZE %02d" % numero
   end
   
   def numero
      self[:num_zona]
   end
   
   def id
      self[:cod_objeto]
   end
   
   #def self.numero_por_id(id)
   #   where("cod_objeto" => id).first.numero
   #end
   
   def self.numero(id)
      find(id).numero
   end
end
