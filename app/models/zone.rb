class Zone < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.zona'
   set_primary_key 'cod_objeto'
   
   has_many :places,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_zona
   
   scope :mt, where("cod_objeto_uf" => "18").order("#{table_name}.num_zona")
   
   def numero
      self[:num_zona]
   end
   
   def id
      self[:cod_objeto]
   end
   
   def municipios
   end
   
   def self.numero_por_id(id)
      where("cod_objeto" => id).first.numero
   end
end
