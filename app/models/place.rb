class Place < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.local_votacao'
   set_primary_key 'cod_objeto'

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
   
   def numero_zona
      Zone.numero_por_id(self.zone_id)
   end
   
   def city_id
      self[:cod_objeto_localidade]
   end
   
   def nome_municipio
      City.nome_por_id(self.city_id)
   end
   
   def id
      self[:cod_objeto]
   end
   
   def numero
      self[:num_local]
   end
   
   def self.numero_por_id(id)
      where(:cod_objeto => id).first.numero
   end
   
   def self.mt
      self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and z.cod_objeto_uf = '18' ORDER BY z.num_zona, l.nom_localidade")
   end
   
   def self.por_zona(zona)
      self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and z.num_zona = '#{zona}' ORDER BY l.nom_localidade")
   end
   
   def self.por_municipio(mun)
      self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and l.cod_localidade_tse = #{mun} ORDER BY z.num_zona, l.nom_localidade")
   end

   def self.por_zona_municipio(zona, mun)
      self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto AND z.num_zona = #{zona} AND l.cod_localidade_tse = #{mun} ORDER BY l.nom_localidade")
   end

   
end
