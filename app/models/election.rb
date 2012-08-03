class Election < ActiveRecord::Base

   has_many :electoral_units
   has_many :electoral_models

   has_many :cities, :through => :electoral_units, :uniq => true
            #:primary_key => :cod_objeto,
            #:foreign_key => :cod_objeto_zona

   has_many :zones, :through => :electoral_units, :uniq => true
            #:primary_key => :cod_objeto,
            #:foreign_key => :cod_objeto_zona

   scope :ativas, where("status" => 1)
   scope :boas, ativas
   
   def data
      ElectionDate.find(self[:election_date_id]).dat_eleicao
   end
   
   def unidades_eleitorais
      self.electoral_units
   end
   
   def unidades
      self.electoral_units
   end
   
   def municipios
      municipios_ids = unidades.collect { |m| m.city_id.to_s }
      return City.where( :cod_objeto => municipios_ids )
   end
   
   def municipios_por_zona(zona)
      muns_ids = unidades.select{|u| u.zone_id = zona.id }.collect{ |u| u.city_id.to_s }
      return City.where( :cod_objeto => muns_ids )
   end
   
   def zonas
      zonas_ids = unidades.collect { |m| m.zone_id.to_s }
      return Zone.where( :cod_objeto => zonas_ids )
   end
   
   def qtos_municipios_por_zona(zid)
      unidades.select{ |u| u.zone_id == zid }.size
   end
   
   def qtd_locais
      qtd_locais = 0
      unidades.each { |u| qtd_locais += u.electoral_places.count }
      return qtd_locais
   end
   
   def qtd_secoes
      qtd_secoes = 0
      unidades.each { |u| qtd_secoes += u.electoral_places.sum(:secoes) }
      return qtd_secoes
   end
   
   def qtd_secoes_por_zona(zona)
      qtd_secoes = 0
      ElectoralUnit.por_eleicao(self.id).por_zona(zona.id).each { |u| qtd_secoes += u.qtd_secoes }
      return qtd_secoes
   end
   
   def eleitorado
      unidades.sum(:eleitorado)      
   end
   
   def agregacoes
      unidades.sum(:agregacoes)      
   end
   
   def mrjs
      unidades.sum(:mrjs_atendidas)      
   end
    
   def ues_de_secao
      unidades.sum(:ues_de_secao)      
   end   
   
   def ues_de_contingencia
      unidades.sum(:ues_de_contingencia)      
   end   
   
   def ues
      unidades.sum(:ues_de_secao)+unidades.sum(:ues_de_contingencia)+unidades.sum(:mrjs_atendidas)
   end
end
