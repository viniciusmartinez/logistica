module OficiaisHelper

   def numero_agregacoes_efetivas(zona, mun)
      num_agrega = Aggregation.agregacao.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size
      num_desagrega = Aggregation.desagregacao.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size
  
      @num_agregacoes = (num_agrega - num_desagrega)
      @total_agregacoes += @num_agregacoes
      
      return @num_agregacoes
   end

   def numero_mrjs(zona, mun)
      @num_mrjs = Mrj.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size

      @total_mrjs += @num_mrjs
      return @num_mrjs
   end
   
   def numero_secoes(zona,municipio)
      
      locais = Place.por_zona(zona.numero).por_municipio(municipio.numero).ativos
      secoes = Array.new(locais.size) { 0 }
      
      locais.each_with_index { |local,index| secoes[index] = Station.por_local_id(local.id).size }
  
      @secoes = Station.por_zona_municipio(zona.id, municipio.id)
      @total_secoes += @secoes.size
      return secoes
   end
   
   def numero_urnas_de_secao(num_zona)
      @num_urnas_de_secao = @secoes.size - @num_agregacoes + @num_mrjs
      @total_urnas_de_secao += @num_urnas_de_secao
      
      #@urnas_por_zona[num_zona] = 0 unless @urnas_por_zona[num_zona]
      @urnas_por_zona[num_zona] += @num_urnas_de_secao
      
      return @num_urnas_de_secao
   end

   def numero_urnas_de_contingencia(num_zona)
      @num_urnas_de_contingencia = (@num_urnas_de_secao*0.25).ceil
      @total_urnas_de_contingencia += @num_urnas_de_contingencia
      
      #@urnas_por_zona[num_zona] = 0 unless @urnas_por_zona[num_zona] # tirei pq calcula de secao primeiro
      @urnas_por_zona[num_zona] += @num_urnas_de_contingencia     
      
      return @num_urnas_de_contingencia
   end

   def matriz_local_eleitorado(zona,municipio)
      
      log = []
   	index_locais = 0
   	@total_eleitores = 0
   	
   	logistica_municipio = @logistica["ze"]["#{zona.numero_bonito}"]["mun"]["#{municipio.numero}"]
   	
      logistica_municipio["local"].each do |log_numero_local, logistica_local|
         log[index_locais] = []
         logistica_local["secao"].each do |log_numero_secao, logistica_secao|
            @total_eleitores += logistica_secao["eleitorado"]
            log[index_locais] << logistica_secao["eleitorado"]
         end
         
         index_locais += 1
      end
      
      return log
      
      #eleitorado = 0
      #secoes = Station.por_zona_municipio(zona.id,municipio.id)
      #eleitores = Array.new
      
      #secoes.each do |secao|
      #   eleitores << secao.qtd_aptos
      #   eleitorado += secao.qtd_aptos
      #end
      @total_eleitores += eleitorado
      #return eleitores #number_with_delimiter(eleitorado, :delimiter => ".")
      
   end

end
