class OficiaisController < ApplicationController
   respond_to :html, :js, :pdf
  
   def index
      @eleicoes = Election.boas
      @eleicao = Election.new
      
      if @eleicoes.size < 2
         @eleicao_escolhida = @eleicoes.first
      end
      
   end
   
   def distribuicao_tu
      logistica
      
      respond_to do |format|
        format.js
        format.html
        format.pdf {
          @template_format = :html
          html = render_to_string(:layout => false , :action => "distribuicao_tu.html.erb")
          kit = PDFKit.new(html)
          kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/oficiais.css.scss"
          send_data(kit.to_pdf, :filename => "DistribuicaoTU.pdf", :type => 'application/pdf')
          return # to avoid double render call
        }
      end

   end
   
   def logistica
   
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
      #@logistica["mrj"] = 0

      # logistica MRJ
      
      @log_mrj = Array.new(151)
      #@log_mrj['excecoes'] =
      #{
      #      [5, 90646] => 4,
      #      [21, 90603] => 7,
      #      [36, 90913] => 1,
      #      [60, 90484] => 3
      #}
      
      # unidades de logistica
      @ul = Hash.new
      id = 1
      @eleicao.zonas.each do |zona|
         @eleicao.municipios_por_zona(zona).each do |mun|
            
            @ul[id] = [zona.numero,mun.numero]
            id += 1
         
            #locais = Place.ativos.por_zid_mid(zona.id, mun.id)
            #locais.each do |local|
            #end
         end
      end
      
      # logistica de ue         
      @eleicao.zonas.each do |zona|
         
         log_z = @logistica["ze"][zona.numero] = Hash.new
         
         municipios = @eleicao.municipios_por_zona(zona)
         log_z["mun"] = Hash.new(municipios.size)
         
         log_z["ues_por_modelo"] = Array.new(5) { 0 }
         
         municipios.each do |mun|
 
            log_zm = log_z["mun"][mun.numero] = Hash.new

            #log_zm["mrj"] = mrj = Mrj.por_dataeleicao(@eleicao.election_date_id).por_zona(zona.id).por_municipio(mun.id).size
            #@logistica["mrj"] += mrj

            log_zm["ue"] = 0
            log_zm["agregas"] = 0
            log_zm["uer"] = 0
            
            locais = Place.ativos.por_zid_mid(zona.id, mun.id)
            log_zm["local"] = Hash.new(locais.size)
            @logistica["locais"] += locais.size
            
            secoes_mun = 0
            agregacoes_mun = 0

            locais.each do |local|

               log_zml = log_zm["local"][local.numero] = Hash.new
              
               log_zml["secoes"] = secoes = Station.ativas.por_local(local).count
               secoes_mun += secoes
               
               #secoes.each do |secao|
               
                  #log_zmls = log_zml["secao"][secao.numero] = Hash.new
                  #log_zmls["eleitorado"] = secao.qtd_aptos
                  #@logistica["eleitorado"] += secao.qtd_aptos
                  #eleitorado_mun += secao.qtd_aptos
                  
                  #nagregas += 1 if secao.agregada?(@eleicao.election_date_id)

               #end # fim stations
               
               nagregas = local.agregacoes(@eleicao)
               agregacoes_mun += nagregas 
                
               log_zm["ue"] += (secoes-nagregas)
               @logistica["ue"] += (secoes-nagregas)
               
               # 2UER com 9UE
               calculo_uer = ((secoes-nagregas)*0.12).ceil
               log_zm["uer"] += calculo_uer
               @logistica["uer"] += calculo_uer

            end # fim places
            
            log_zm["agregas"] = agregacoes_mun
            log_zm["secoes"] = secoes_mun
            log_zm["eleitorado"] = Station.ativas.por_zona(zona).por_municipio(mun).sum(:qtd_aptos) 
            
            @logistica["secoes"] += secoes_mun
            @logistica["agregas"] += agregacoes_mun
            
         end # fim cities
      end # fim zones
      
      # logistica mrj
      @log_mrj[0] = Array.new(3) {0}
      @ul.each do |id, zm|
         @log_mrj[id] = Array.new(3) {0}
      end
      
      solicitadas =
      [
         0, # TRE
         2, # 1a ZE
         0,0, # 2a ZE
         0,0,0, # ...
         2,
         4,0,
         2,
         0,0,
         0,0,0,0,0,
         2,0,0,
         5,
         0,0,
         0,0,
         2,0,0,0,
         0,0,0,
         0,0,0,0,
         3,0,0,0,
         0,0,0,0,
         0,0,0,0,0,
         4,
         1,
         21,0,0,
         8,1,1,1,
         1,0,0,0,0,
         0,0,0,
         3,0,0,
         0,0,0,
         2,0,0,0,
         0,0,0,
         0,0,
         4,1,0,
         2,2,
         14,2,1,
         0,0,0,0,
         0,0,0,
         3,0,
         2,
         0,
         2,0,
         2,0,
         0,0,0,
         2,0,0,0,0,
         0,0,
         2,0,0,
         0,0,
         0,0,
         6,1,
         1,0,0,0,
         0,0,
         1,
         0,0,0,
         1,
         0,0,0,
         1,0,0,
         0,
         1,
         0,
         2,0, # ...
         2,0, # 58a ZE
         3, # 60a ZE
         0,0,0,0 # 61a ZE
      ]
      
      @ul.each do |id,zm|
        
            # variaveis auxiliares
            z = zm[0] # zona numero
            m = zm[1] # mun numero
            eleitorado_mun = @logistica["ze"][z]["mun"][m]["eleitorado"]
         
            # solicitadas
            @log_mrj[id][0] = solicitadas[id]
            @log_mrj[0][0] += solicitadas[id]
            
            # calculadas
            @log_mrj[id][1] = calculadas = (eleitorado_mun<=15000? 0 : (eleitorado_mun/15000.to_f).ceil)
            @log_mrj[0][1] += calculadas
            
            # excecoes
            if z == 5 and m == 90646
               @log_mrj[id][2] = disponibilizadas = 4
            elsif z == 21 and m == 90603
               @log_mrj[id][2] = disponibilizadas = 7
            elsif z == 36 and m == 90913
               @log_mrj[id][2] = disponibilizadas = 1
            elsif z == 60 and m == 90484
               @log_mrj[id][2] = disponibilizadas = 3
               
            # regra geral: calculadas # tem algo errado
            
            else
               @log_mrj[id][2] = disponibilizadas = @log_mrj[id][1]
            end
            
            @log_mrj[0][2] += disponibilizadas

      end
      
      # distribuicao de modelos de ue
=begin
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
      
      
      [1, 37, 39, 51, 54, 55].each do |nze|
      
         log_ze = @logistica["ze"][nze]
      
         log_ze["mun"].each do |nmun, log_mun|
         
            ues_do_mun = @log_mrj[ @ul.index([nze,nmun]) ][2] + log_mun["ue"] + log_mun["uer"]
         
        
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
      [20, 49, 58, 3, 5, 7, 10, 12, 13, 14, 17, 22, 32, 34, 38, 40, 45, 46, 52].each do |nze|

         log_ze = @logistica["ze"][nze]
      
         log_ze["mun"].each do |nmun, log_mun|
         
            ues_do_mun = @log_mrj[ @ul.index([nze,nmun]) ][2] + log_mun["ue"] + log_mun["uer"]
         
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
      [11, 24, 33, 36, 42, 44, 48, 50, 61].each do |nze|
         
         log_ze = @logistica["ze"][nze]
      
         log_ze["mun"].each do |nmun, log_mun|
         
            ues_do_mun = @log_mrj[ @ul.index([nze,nmun]) ][2] + log_mun["ue"] + log_mun["uer"]

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
=end   
   end

   def distribuicao_ue
      
      @distribuicao_ue = true
 
      logistica
      
      respond_to do |format|
        format.js
        format.html
        format.pdf {
          @template_format = :html
          html = render_to_string(:action => "distribuicao_ue.html.erb")
          kit = PDFKit.new(html)
          kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/oficiais.css.scss"
          send_data(kit.to_pdf, :filename => "DistribuicaoUE.pdf", :type => 'application/pdf')
          return # to avoid double render call
        }
      end
   end
  
   def eleicao
      @eleicao_escolhida = Election.find(params['election']['id'])
      @eleicao = Election.new
      #Rails.logger.info("Eleicao: #{params.inspect}")
      
   end
   
   def show
   
   end

end
