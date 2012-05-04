class OficiaisController < ApplicationController
   respond_to :html, :js
  
   def index
      @eleicoes = Election.all
      @eleicao = Election.new
   end
   
   def distribuicao_tu
      distribuicao_ue

   end

   def distribuicao_ue
      
      @distribuicao_ue = true
 
      @eleicao = Election.find(params['election']['id'])

      # logistica
      
      @logistica = Hash.new
      @logistica["ze"] = Hash.new
      @logistica["locais"] = 0
      @logistica["secoes"] = 0
      @logistica["ue"] = 0
      @logistica["uer"] = 0
      @logistica["agregas"] = 0  
      @logistica["eleitorado"] = 0
      @logistica["mrj"] = 0
      
      @eleicao.zonas.each do |zona|
         @logistica["ze"]["#{zona.numero_bonito}"] = Hash.new
         @logistica["ze"]["#{zona.numero_bonito}"]["mun"] = Hash.new
         @logistica["ze"]["#{zona.numero_bonito}"]["ues_por_modelo"] = Array.new(5) { 0 }
         
         @eleicao.municipios_por_zona(zona).each do |mun|
         
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"] = Hash.new
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"] = Hash.new

            # mrj
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["mrj"] = mrj = Mrj.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size
            @logistica["mrj"] += mrj
            
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["secoes"] = 0
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["ue"] = 0
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["agregas"] = 0
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["uer"] = 0
            
            locais = Place.ativos.por_zid_mid(zona.id, mun.id)
            @logistica["locais"] += locais.size
            locais.each do |local|

               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"] = Hash.new
               #@logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["nome"] = local.nome
               #@logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["bairro"] = local.bairro.nome
               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"] = Hash.new
               
               nagregas = 0
               secoes = Station.ativas.por_local(local)
               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["secoes"] += secoes.size
               @logistica["secoes"] += secoes.size
               
               secoes.each do |secao|
               
                  @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"]["#{secao.numero}"] = Hash.new
                  @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"]["#{secao.numero}"]["eleitorado"] = secao.qtd_aptos
                  @logistica["eleitorado"] += secao.qtd_aptos
                  
                  if secao.agregada?(@eleicao.election_date_id)
                  
                     #@logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"]["#{secao.numero}"]["agregada"] = true
                     
                     nagregas += 1
                     
                  #else
                     #@logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"]["#{secao.numero}"]["agregada"] = false
                  end
                  
               end # fim stations

               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["agregas"] += nagregas 
               @logistica["agregas"] += nagregas
                
               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["ue"] += (secoes.size-nagregas)
               @logistica["ue"] += (secoes.size-nagregas)
               
               # 2UER com 9UE
               calculo_uer = ((secoes.size-nagregas)*0.12).ceil
               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["uer"] += calculo_uer
               @logistica["uer"] += calculo_uer

            end # fim places
         end # fim cities
      end # fim zones
      
      # distribuicao de modelos de ue
      
      @d = Hash.new
      @d["ue"] = 8521
      @d["ue2004"] = 634
      @d["ue2004usado"] = 0
      @d["ue2008"] = 379
      @d["ue2008usado"] = 0
      @d["ue2009"] = 3249
      @d["ue2009usado"] = 0
      @d["ue2010"] = 3272
      @d["ue2010usado"] = 0
      @d["ue2011"] = 984
      @d["ue2011usado"] = 0
      
      
      ["01", "37", "39", "51", "54", "55"].each do |nze|
      
         log_ze = @logistica["ze"][nze]
      
         log_ze["mun"].each do |nmun, log_mun|
         
            ues_do_mun = log_mun["mrj"] + log_mun["ue"] + log_mun["uer"]
         
        
            if ues_do_mun > 0 and @d["ue2004usado"] < @d["ue2004"]
          
               ue2004 = (@d["ue2004"]-@d["ue2004usado"] >= ues_do_mun) ? ues_do_mun : (@d["ue2004"]-@d["ue2004usado"])
               log_ze["ues_por_modelo"][0] += ue2004
               @d["ue2004usado"] += ue2004
               ues_do_mun -= ue2004
              
            end
               
            if ues_do_mun > 0 and @d["ue2008usado"] < @d["ue2008"]
          
               ue2008 = (@d["ue2008"]-@d["ue2008usado"] >= ues_do_mun) ? ues_do_mun : (@d["ue2008"]-@d["ue2008usado"])
               log_ze["ues_por_modelo"][1] += ue2008
               @d["ue2008usado"] += ue2008
               ues_do_mun -= ue2008
              
            end

            if ues_do_mun > 0 and @d["ue2009usado"] < @d["ue2009"]
          
               ue2009 = (@d["ue2009"]-@d["ue2009usado"] >= ues_do_mun) ? ues_do_mun : (@d["ue2009"]-@d["ue2009usado"])
               log_ze["ues_por_modelo"][2] += ue2009
               @d["ue2009usado"] += ue2009
               ues_do_mun -= ue2009

            end
         end # fim muns
      end # fim cuiaba
      
      # vg + zonas 2009      
      ["20", "49", "58", "03", "05", "07", "10", "12", "13", "14", "17", "22", "32", "34", "38", "40", "45", "46", "52"].each do |nze|

         log_ze = @logistica["ze"][nze]
      
         log_ze["mun"].each do |nmun, log_mun|
         
            ues_do_mun = log_mun["mrj"] + log_mun["ue"] + log_mun["uer"]
         
            if ues_do_mun > 0 and @d["ue2009usado"] < @d["ue2009"]
          
               ue = (@d["ue2009"]-@d["ue2009usado"] >= ues_do_mun) ? ues_do_mun : (@d["ue2009"]-@d["ue2009usado"])
               log_ze["ues_por_modelo"][2] += ue
               @d["ue2009usado"] += ue
               ues_do_mun -= ue

            end
        
            if ues_do_mun > 0 and @d["ue2010usado"] < @d["ue2010"]
          
               ue = (@d["ue2010"]-@d["ue2010usado"] >= ues_do_mun) ? ues_do_mun : (@d["ue2010"]-@d["ue2010usado"])
               log_ze["ues_por_modelo"][3] += ue
               @d["ue2010usado"] += ue
               ues_do_mun -= ue
              
            end
            
         end # fim muns
      end # fim vg
      
      # zonas 2011
      ["11", "24", "33", "36", "42", "44", "48", "50", "61"].each do |nze|
         
         log_ze = @logistica["ze"][nze]
      
         log_ze["mun"].each do |nmun, log_mun|
         
            ues_do_mun = log_mun["mrj"] + log_mun["ue"] + log_mun["uer"]

            if ues_do_mun > 0 and @d["ue2011usado"] < @d["ue2011"]
          
               ue = (@d["ue2011"]-@d["ue2010usado"] >= ues_do_mun) ? ues_do_mun : (@d["ue2011"]-@d["ue2011usado"])
               log_ze["ues_por_modelo"][4] += ue
               @d["ue2011usado"] += ue
               ues_do_mun -= ue
              
            end

            # se nao tiver 2011 vai de 2009
            if ues_do_mun > 0 and @d["ue2009usado"] < @d["ue2009"]
          
               ue = (@d["ue2009"]-@d["ue2009usado"] >= ues_do_mun) ? ues_do_mun : (@d["ue2009"]-@d["ue2009usado"])
               log_ze["ues_por_modelo"][2] += ue
               @d["ue2009usado"] += ue
               ues_do_mun -= ue

            end
         end # fim muns
      end # fim zonas 2011
 
   end
  
   def eleicao
      @eleicao_escolhida = Election.find(params['election']['id'])
      @eleicao = Election.new
      #Rails.logger.info("Eleicao: #{params.inspect}")
   end

end
