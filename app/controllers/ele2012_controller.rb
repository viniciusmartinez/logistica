class Ele2012Controller < ApplicationController

   def index
      
      @eleicao = Election.find(2)
      
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
end
