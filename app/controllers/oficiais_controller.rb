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
            @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{mun.numero}"]["MRJ"] = Mrj.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size
            
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
      
      @total_eleitores_do_municipio = 0
      @total_eleitores_eleicao = 0
      
      @num_agregacoes = 0
      @total_agregacoes = 0
      
      @total_mrj_eleicao = 0
      @total_ue_eleicao = 0
      @total_uer_eleicao = 0
      
      @ue = Array.new(62){ 0 }
      @uer = Array.new(62){ 0 }
      @mrj = Array.new(62){ 0 }
   end
  
   def eleicao
      @eleicao_escolhida = Election.find(params['election']['id'])
      @eleicao = Election.new
      #Rails.logger.info("Eleicao: #{params.inspect}")
   end

end
