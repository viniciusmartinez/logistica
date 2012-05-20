module OficiaisHelper

   #def numero_agregacoes_efetivas(zona, mun)
      #num_agrega = Aggregation.agregacao.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size
      #num_desagrega = Aggregation.desagregacao.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size
  
      #@num_agregacoes = (num_agrega - num_desagrega)
      #@total_agregacoes += @num_agregacoes
      
      #return @num_agregacoes  
   #end

   #def numero_mrjs(zona, municipio)
   
   #   mrj = @logistica["ze"][zona.numero]["mun"][municipio.numero]["mrj"]
   
   #   @mrj[zona.numero] += mrj
   #   @total_mrj_eleicao += mrj

   #   return mrj
   #end
   
   #def lista_numero_secoes_por_local(zona,municipio)
      
   #   locais = Place.por_zona(zona.numero).por_municipio(municipio.numero).ativos
   #   secoes = Array.new(locais.size) { 0 }
      
   #   locais.each_with_index { |local,index| secoes[index] = Station.por_local_id(local.id).size }
  
   #   @secoes = Station.por_zona_municipio(zona.id, municipio.id)
   #   @total_secoes += @secoes.size
   #   return secoes
   #end

   #def numero_secoes(zona,municipio)

      ##@secoes = Station.por_zona_municipio(zona.id, municipio.id)
      ##@total_secoes += @secoes.size
      ##return @secoes.size
      
      #secoes = 0

      #@logistica["ze"][zona.numero]["mun"][municipio.numero]["local"].each do |nlocal, logistica_local|
      #   secoes += logistica_local["secao"].size
      #end
      
      #return secoes
   #end
   
   #def numero_urnas_de_secao(zona,municipio)
   
   #   total_ue_local = numero_secoes(zona,municipio)
      
   #   @ue[zona.numero] += total_ue_local
   #   @total_ue_eleicao += total_ue_local
      
   #   return total_ue_local
   #end

   #def numero_urnas_de_contingencia(zona,municipio)
      
   #   total_uer_local = 0
      	
      ##if [90670, 91677, 91510].include?(municipio.numero)
      ##   total_uer_local = (Station.por_zona_municipio(zona.id, municipio.id).size*0.1).ceil

      ##else	
         #@logistica["ze"][zona.numero]["mun"][municipio.numero]["local"].each do |log_numero_local, logistica_local|
            #total_uer_local += (logistica_local["secao"].size*0.12).ceil # a partir de 9 UE
         #end
         
      ##end
      
      #@uer[zona.numero] += total_uer_local
      #@total_uer_eleicao += total_uer_local
      
      #return total_uer_local
   #end

   def matriz_eleitorado(zona,municipio)
      log = []
   	index_locais = 0
   	@total_eleitores_do_municipio = 0
   	
   	logistica_municipio = @logistica["ze"][zona.numero]["mun"][municipio.numero]
   	
      logistica_municipio["local"].each do |log_numero_local, logistica_local|
         log[index_locais] = []
         logistica_local["secao"].each do |log_numero_secao, logistica_secao|
            @total_eleitores_do_municipio += logistica_secao["eleitorado"]
            @total_eleitores_eleicao += logistica_secao["eleitorado"]
            log[index_locais] << logistica_secao["eleitorado"]
         end
         
         index_locais += 1
      end
      
      return log
   end

   #def eleitorado(zona,municipio)

   #	eleitorado = 0
  	
   #   @logistica["ze"][zona.numero]["mun"][municipio.numero]["local"].each do |nlocal, log_local|
   #      log_local["secao"].each do |nsecao, log_secao|
   #         eleitorado += log_secao["eleitorado"]
   #      end
   #   end
      
   #   return eleitorado
   #end

   def secoes(zona)

   	secoes = 0

      @logistica["ze"][zona.numero]["mun"].each do |nmun, log_mun|
         log_mun["local"].each do |nlocal, log_local|
            secoes += log_local["secoes"]
         end
      end
      
      return secoes
   end

end
