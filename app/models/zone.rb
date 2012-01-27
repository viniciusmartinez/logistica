class Zone < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.zona'
   set_primary_key 'cod_objeto'
   
   default_scope :order => "#{table_name}.num_zona ASC"
   
   has_many :cities, :through => :places, :uniq => true
   
   has_many :places,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_zona
   
   scope :mt, where("cod_objeto_uf" => "18")
   scope :boas, mt
   
   def nome
      "ZE %02d" % numero
   end
   
   def numero_bonito
      "%02d" % self[:num_zona]
   end
   
   def numero
      self[:num_zona]
   end
   
   def id
      self[:cod_objeto]
   end
   
   def municipio_sede_id
      self[:cod_objeto_localidade]
   end
   
   def self.numero(id)
      find(id).numero
   end
   
   def municipios
      self.cities.select {|m| m.id == self.municipio_sede_id } + self.cities.reject {|m| m.id == self.municipio_sede_id }
   end
end
