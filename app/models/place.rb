class Place < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.local_votacao'
   set_primary_key 'cod_objeto'
   
   @@descritor = 'SITUACAO_LOCAL'
   @@bom = ['ATIVO','BLOQUEADO'] # (1,5)
   
   scope :ordena, :order => "#{table_name}.num_local ASC"

   belongs_to :city, :foreign_key => "cod_objeto_localidade"
   belongs_to :zone, :foreign_key => "cod_objeto_zona"
   belongs_to :neighborhood, :foreign_key => "cod_objeto_bairro"
   
   has_many :stations,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_local
   
   def zone_id
      self[:cod_objeto_zona]
   end
   
   def city_id
      self[:cod_objeto_localidade]
   end
   
   def id
      self[:cod_objeto]
   end
   
   def numero
      self[:num_local]
   end
   
   def nome
      self[:nom_local]
   end
   
   def self.numero(id)
      find(id).numero
   end

   def bairro
      CadNeighborhood.find(self[:cod_objeto_bairro])
   end

   def descricao_situacao
      CadDescritor.descricao_por_descritor_valor(@@descritor,self[:situacao])
   end

   def eleitorado
      Station.por_local(self).sum(:qtd_aptos)
   end
   
   # agregacoes
   
   def agregacoes(eleicao)
      n_agregacoes = Aggregation.agregacao.por_dataeleicao(eleicao.election_date_id).por_local(self).size
      n_desagregacoes = Aggregation.desagregacao.por_dataeleicao(eleicao.election_date_id).por_local(self).size
      
      return n_agregacoes - n_desagregacoes
   end

   # outras associacoes

   def vistorias
      DataelePlace.por_zona_municipio_local(Zone.find(self.zone_id).numero, City.find(self.city_id).numero, self.numero)
   end

   # consultas

   def self.junta
      joins(:city,:zone).order("#{Zone.table_name}.num_zona").order("#{City.table_name}.nom_localidade").ordena
   end
   
   def self.com_secao_com_audio
      select("DISTINCT #{table_name}.cod_objeto").joins(:stations).where("#{Station.table_name}.IND_AUDIO = 1")
   end
   
   def self.mt
      junta.where("#{Zone.table_name}.cod_objeto_uf = '18'")
   end

   def self.ativos
      #where(:situacao => CadDescritor.valores_por_descritor_descricoes(@@descritor,@@bom) )
      where(:situacao => [1,5] )
   end

   def self.por_zona(zona)
      junta.where("#{Zone.table_name}.num_zona = #{zona}")
   end

   def self.por_municipio(mun)
      junta.where("#{City.table_name}.cod_localidade_tse = #{mun}")
   end

   def self.por_zona_municipio(zona, mun)
      junta.where("#{Zone.table_name}.num_zona = #{zona}").where("#{City.table_name}.cod_localidade_tse = #{mun}")
   end

   def self.por_zid(zid)
      where(:cod_objeto_zona => "#{zid}").ordena
   end

   def self.por_zid_mid(zona, mun)
      where(:cod_objeto_zona => "#{zona}").where(:cod_objeto_localidade => "#{mun}").ordena
   end
   
   def self.bons
      return ativos.select { |local| local.eleitorado > 0 }
   end
   
   def self.qtd_com_audio_por_zid_mid(zid, mid)
      Station.com_audio_por_zid_mid_local(zid, mid).count
   end
   
   def self.qtd_rurais_por_ele_zid(ele, zid)
      unidades_ids = ElectoralUnit.por_eleicao(ele).por_zona(zid).collect {|u| u.id }
      cad_locais_ids = ElectoralPlace.where(:electoral_unit_id => unidades_ids).collect {|le| le.place_id }
      rurais_zona = AdjunctPlace.where(:place_id => cad_locais_ids).where(:rural => true).count
      
      return rurais_zona
   end

   def self.qtd_dificil_acesso_por_ele_zid(ele, zid)
      unidades_ids = ElectoralUnit.por_eleicao(ele).por_zona(zid).collect {|u| u.id }
      cad_locais_ids = ElectoralPlace.where(:electoral_unit_id => unidades_ids).collect {|le| le.place_id }
      dificilacesso_zona = AdjunctPlace.where(:place_id => cad_locais_ids).where(:dificil_acesso => true).count
      
      return dificilacesso_zona
   end

   def self.qtd_eletricidade_irregular_por_ele_zid(ele, zid)
      unidades_ids = ElectoralUnit.por_eleicao(ele).por_zona(zid).collect {|u| u.id }
      cad_locais_ids = ElectoralPlace.where(:electoral_unit_id => unidades_ids).collect {|le| le.place_id }
      eletricidade_zona = AdjunctPlace.where(:place_id => cad_locais_ids).where(:eletricidade_irregular => true).count
      
      return eletricidade_zona
   end

   #def self.mt
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and z.cod_objeto_uf = '18' ORDER BY z.num_zona, l.nom_localidade")
   #end
   
   #def self.por_zona(zona)
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and z.num_zona = '#{zona}' ORDER BY l.nom_localidade")
   #end
   
   #def self.por_municipio(mun)
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto and l.cod_localidade_tse = #{mun} ORDER BY z.num_zona, l.nom_localidade")
   #end

   #def self.por_zona_municipio(zona, mun)
   #   self.find_by_sql("select lv.* from admcad.local_votacao lv, admcad.zona z, admcad.localidade l where lv.cod_objeto_zona = z.cod_objeto and lv.cod_objeto_localidade = l.cod_objeto AND z.num_zona = #{zona} AND l.cod_localidade_tse = #{mun} ORDER BY l.nom_localidade")
   #end
end
