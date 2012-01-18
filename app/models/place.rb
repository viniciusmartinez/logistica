class Place < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.local_votacao'
   set_primary_key 'cod_objeto'
   
   #default_scope :order => "#{table_name}.num_local ASC"
   scope :ordena, :order => "#{table_name}.num_local ASC"

   belongs_to :city, :foreign_key => "cod_objeto_localidade"#, :class_name => "City"
   belongs_to :zone, :foreign_key => "cod_objeto_zona"#, :class_name => "Zone"
   
   has_many :stations,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_local #,
            #:order => :ddate,
            #:conditions => ['datasource = ?', '#{self.datasource}']
   
   def zone_id
      self[:cod_objeto_zona]
   end
   
   # place.zone.numero
   #def numero_zona
   #   Zone.numero(self.zone_id)
   #end
   
   def city_id
      self[:cod_objeto_localidade]
   end
   
   # place.city.nome
   #def nome_municipio
   #   City.nome(self.city_id)
   #end
   
   def id
      self[:cod_objeto]
   end
   
   def numero
      self[:num_local]
   end
   
   def self.numero(id)
      find(id).numero
   end
   
   #def self.mt
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and z.cod_objeto_uf = '18' ORDER BY z.num_zona, l.nom_localidade")
   #end
   
   def self.mt
      junta.where("#{Zone.table_name}.cod_objeto_uf = '18'")
   end
   
   #def self.por_zona(zona)
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and z.num_zona = '#{zona}' ORDER BY l.nom_localidade")
   #end
   
   def self.junta
      joins(:city,:zone).order("#{Zone.table_name}.num_zona").order("#{City.table_name}.nom_localidade").ordena
   end
   
   def self.por_zona(zona)
      junta.where("#{Zone.table_name}.num_zona = #{zona}")
   end
   
   #def self.por_municipio(mun)
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and l.cod_localidade_tse = #{mun} ORDER BY z.num_zona, l.nom_localidade")
   #end
   
   def self.por_municipio(mun)
      junta.where("#{City.table_name}.cod_localidade_tse = #{mun}")
   end

   #def self.por_zona_municipio(zona, mun)
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto AND z.num_zona = #{zona} AND l.cod_localidade_tse = #{mun} ORDER BY l.nom_localidade")
   #end
   
   def self.por_zona_municipio(zona, mun)
      junta.where("#{Zone.table_name}.num_zona = #{zona}").where("#{City.table_name}.cod_localidade_tse = #{mun}")
   end

   
end
