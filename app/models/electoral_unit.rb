class ElectoralUnit < ActiveRecord::Base
   belongs_to :election
   belongs_to :city
   belongs_to :zone
   belongs_to :adjunct_city, :primary_key => :city_id, :foreign_key => :city_id
   
   has_many :electoral_places
   has_many :electoral_models
   
   def locais
      self.electoral_places
   end
   
   def modelos_ues
      self.electoral_models
   end

   def zona
      Zone.find(self[:zone_id])
   end
   
   def zona_id
      self[:zone_id]
   end
   
   def municipio_id
      self[:city_id]
   end
   
   def municipio
      City.find(self[:city_id])
   end

   def self.por_zona(zid)
      where("zone_id = '#{zid}'")
   end

   def self.por_municipio(mid)
      where("city_id = '#{mid}'")
   end

   def self.por_eleicao(eid)
      where("election_id = #{eid}")
   end
   
   def qtd_secoes
      self.electoral_places.sum(:secoes)
   end
   
   def self.distancia_decrescente
      joins(:adjunct_city).order("#{AdjunctCity.table_name}.kms_de_cuiaba DESC")
   end

end
