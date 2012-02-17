class OficiaisController < ApplicationController
   respond_to :html, :js
  
   def index
      @eleicoes = Election.all
      @eleicao = Election.new
   end

   def distribuicao_ue
      
      @distribuicao_ue = true
   
      @eleicao = Election.find(params['election']['id'])
      
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
   end
  
   def eleicao
      @eleicao_escolhida = Election.find(params['election']['id'])
      @eleicao = Election.new
      #Rails.logger.info("Eleicao: #{params.inspect}")
   end

end
