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
      @secoes = Station.por_zona_municipio(zona.id, municipio.id)
      @total_secoes += @secoes.size
      return @secoes.size
   end
   
   def numero_urnas_de_secao
      @num_urnas_de_secao = @secoes.size - @num_agregacoes + @num_mrjs
      @total_urnas_de_secao += @num_urnas_de_secao
      
      return @num_urnas_de_secao
   end

   def numero_urnas_de_contingencia
      @num_urnas_de_contingencia = (@num_urnas_de_secao*0.25).ceil
      @total_urnas_de_contingencia += @num_urnas_de_contingencia
      
      return @num_urnas_de_contingencia
   end

   def eleitorado(zona,municipio)
      eleitorado = 0
      Station.por_zona_municipio(zona.id,municipio.id).each {|secao| eleitorado += secao.qtd_aptos}
      @total_eleitores += eleitorado
      return number_with_delimiter(eleitorado, :delimiter => ".")
   end

end
