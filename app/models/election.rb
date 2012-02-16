class Election < ActiveRecord::Base

   has_many :electoral_units

   has_many :cities, :through => :electoral_units, :uniq => true
            #:primary_key => :cod_objeto,
            #:foreign_key => :cod_objeto_zona

   has_many :zones, :through => :electoral_units, :uniq => true
            #:primary_key => :cod_objeto,
            #:foreign_key => :cod_objeto_zona
   
   def unidades_eleitorais
      self.electoral_units
   end
   
   def unidades
      self.electoral_units
   end
            
   def municipios
      if unidades.size == 1 and unidades.first.zone_id == 0
         return City.bons
      else
         municipios_ids = unidades.collect { |m| m.city_id.to_s }
         return City.where( :cod_objeto => municipios_ids )
      end
   end
   
   def municipios_por_zona(zona)
      if unidades.first.zone_id == 0
         return zona.municipios
      else
         muns_ids = unidades.select{|m| m.zone_id = zona.id }.collect{ |m| m.city_id.to_s }
         return City.where( :cod_objeto => muns_ids )
      end
   end
   
   def zonas
      if unidades.size == 1 and unidades.first.zone_id == 0
         return Zone.boas
      else
         zonas_ids = unidades.collect { |m| m.zone_id.to_s }
         return Zone.where( :cod_objeto => zonas_ids )
      end
   end
   
   def qtos_municipios_por_zona(zid)
      unidades.select{ |u| u.zone_id == zid }.size
   end
end
