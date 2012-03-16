class OficiaisController < ApplicationController
   respond_to :html, :js
  
   def index
      @eleicoes = Election.all
      @eleicao = Election.new
   end

   def distribuicao_ue
      
      @distribuicao_ue = true
   
      @eleicao = Election.find(params['election']['id'])

      # logistica
      
      #@logistica = Array.new(@eleicao.zonas.size)
      @logistica = Hash.new
      @logistica["ze"] = Hash.new
           
      @eleicao.zonas.each do |zona|
         @logistica["ze"]["#{zona.numero_bonito}"] = Hash.new
         @logistica["ze"]["#{zona.numero_bonito}"]["mun"] = Hash.new
         
         @eleicao.municipios_por_zona(zona).each do |mun|
         
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"] = Hash.new
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"] = Hash.new
            
            Place.ativos.por_zid_mid(zona.id, mun.id).each do |local|

               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"] = Hash.new
               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["nome"] = local.nome
               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["bairro"] = local.bairro.nome

               @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"] = Hash.new
               
               Station.ativas.por_local(local).each do |secao|
               
                  @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"]["#{secao.numero}"] = Hash.new
                  @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"]["#{secao.numero}"]["eleitorado"] = secao.qtd_aptos
                  @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["local"]["#{local.numero}"]["secao"]["#{secao.numero}"]["agregada"] = secao.agregada?(@eleicao.election_date_id)
               end
            end
         end
      end


      
      # end logistica
      
      @total_locais = 0
      
      @secoes = nil
      @total_secoes = 0
      
      @total_eleitores = 0
      
      @num_agregacoes = 0
      @total_agregacoes = 0
      
      @num_mrjs = 0
      @total_mrjs = 0

      @num_urnas_de_secao = 0
      @total_urnas_de_secao = 0
      
      @num_urnas_de_contingencia = 0
      @total_urnas_de_contingencia = 0
      
      @urnas_por_zona = Array.new(62){ 0 }
   end
  
   def eleicao
      @eleicao_escolhida = Election.find(params['election']['id'])
      @eleicao = Election.new
      #Rails.logger.info("Eleicao: #{params.inspect}")
   end

end
