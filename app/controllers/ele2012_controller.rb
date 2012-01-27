class Ele2012Controller < ApplicationController

   def index
      @zonas = Zone.boas
      @total_municipios = City.bons.size
      
      @total_locais = 0
      
      @secoes = nil
      @total_secoes = 0
      
      @eleicao = ElectionDate.find("Ba1709080617161528") # primeiro turno ele2010
      
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
