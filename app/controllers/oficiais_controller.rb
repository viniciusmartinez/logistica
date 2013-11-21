class OficiaisController < ApplicationController
   respond_to :html, :js, :pdf, :xls
  
   def index
      @eleicoes = Election.boas
      @eleicao = Election.new
      
      if @eleicoes.size < 2
         @eleicao_escolhida = @eleicoes.first
      end
      
   end

   def distribuicao_me

      @distribuicao_me = true
      @eleicao = Election.find(params['election']['id'])
      
      #AdjunctPlace.find(:all).each do |adj_local|
      #   adj_local.dificil_acesso = 1 if adj_local.rural == true
      #   adj_local.save  
      #end
      
      respond_to do |format|
        format.js
        format.html
        format.xls
        format.pdf {
          @template_format = :html
          html = render_to_string(:layout => false , :action => "distribuicao_me.html.erb")
          kit = PDFKit.new(html)
          kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/oficiais.css.scss"
          send_data(kit.to_pdf, :filename => "DistribuicaoME.pdf", :type => 'application/pdf')
          return # to avoid double render call
        }
      end

   end
   
   def distribuicao_lacres

      @distribuicao_lacres = true
      @eleicao = Election.find(params['election']['id'])
      
      respond_to do |format|
        format.js
        format.html
        format.xls
        format.pdf {
          @template_format = :html
          html = render_to_string(:layout => false , :action => "distribuicao_lacres.html.erb")
          kit = PDFKit.new(html)
          kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/oficiais.css.scss"
          send_data(kit.to_pdf, :filename => "DistribuicaoLacres.pdf", :type => 'application/pdf')
          return # to avoid double render call
        }
      end

   end   
   
   def distribuicao_tu

      @distribuicao_tu = true
      @eleicao = Election.find(params['election']['id'])
         
      #regera_banco_logistica = false
      #logistica if regera_banco_logistica
      
      respond_to do |format|
        format.js
        format.html
        format.xls
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
   
      eleicao = Election.find(params['election']['id'])
   
      # Tabela de Solicitacoes de Urnas para MRJ
      # fazer isto aqui virar uma Consulta gravada no banco
      solicitadas =
      [
         0, # TRE
         2, # 1a ZE
         0,0, # 2a ZE
         0,0,0, # 3a ZE
         2, # 4a ZE
         4,0, # 5a ZE
         2, # 6a ZE
         0,0, # 7a ZE
         0,0,0,0,0, # 8a ZE
         2,0,0, # 9a ZE
         5, # 10a ZE
         0,2, # 11a ZE
         0,0, # 12a ZE
         2,0,0,0, # 13a ZE
         0,0,0, # 14a ZE
         0,0,0,0, # 15
         3,0,0,0, # 16
         0,0,0,0, # 17
         0,0,0,0,0, # 18
         4, # 19
         1, # 20
         21,0,0, # 21
         8,1,1,1, # 22
         1,0,0,0,0, # 23 
         0,0,0, # 24
         3,0,0, # 25
         0,0,0, # 26 
         2,0,0,0, # 27
         0,0,0, # 28
         0,0, # 29
         4,1,0, # 30
         2,2, # 31 
         0,0,0, # 32 ...
         0,0,0,0, # 33
         0,0,0, # 34
         3,0, # 35
         2, # 36
         0, # 37
         2,0, # 38
         2,0, # 39
         0,0,0, # 40
         2,0,0,0,0, # 41
         0,0, # 42
         3,0,0, # 43a ZE
         0,0, # 44a ZE
         0,0, # 45a ZE
         6,1, # 46a ZE 
         1,0,0,0, # 47a ZE
         0,0, # 48a ZE
         1, # 49a ZE
         0,0,0, # 50a ZE
         1, # 51a ZE
         0,0,0, # 52a ZE
         1,0,0, # 53a ZE
         0, # 54a ZE
         1, # 55a ZE
         0, # 56a ZE
         2,0, # 57a ZE
         2,0, # 58a ZE
         3, # 60a ZE
         0,0,0,0 # 61a ZE
      ]

      # itera todas as unidades da eleicao
      eleicao.unidades.each_with_index do |unidade,index|

         # preambulo
         unidade.agregacoes = 0
         unidade.ues_de_secao = 0
         unidade.ues_de_contingencia = 0
         
         zona = unidade.zona
         mun = unidade.municipio
         z = zona.numero
         m = mun.numero

         # marca como sede         
         if zona.cod_objeto_localidade == unidade.municipio_id
            unidade.sede = true
         else
            unidade.sede = false
         end

         # destroi os locais eleitorais da unidade
         unidade.electoral_places.each { |local| local.destroy }
         # fim

         # pega os locais do cadastro
         locais = Place.por_zid_mid(unidade.zona_id, unidade.municipio_id).bons

         # gera de novo conforme banco CAD atual
         locais.each do |local|
            local_eleitoral = ElectoralPlace.new
            local_eleitoral.electoral_unit_id = unidade.id
            local_eleitoral.place_id = local.id
            local_eleitoral.secoes = secoes = Station.ativas.por_local(local).count
            local_eleitoral.agregacoes = agregas = local.agregacoes(@eleicao)
            local_eleitoral.save
         
            unidade.agregacoes += agregas
            unidade.ues_de_secao += secoes-agregas
            unidade.ues_de_contingencia += ((secoes-agregas)*0.2).ceil
         end
         
         # sobra feita a mao.. arrumar pra distribuir se sobrar multiplos de (eleicao.unidades.size) urnas
         # unidade.ues_de_contingencia += 1
         unidade.ues_de_contingencia += ( ( mun.adjunto.kms_de_cuiaba / 550.to_f ).ceil )
         
         # eleitorado
         unidade.eleitorado = Station.ativas.por_zona(unidade.zona).por_municipio(unidade.municipio).sum(:qtd_aptos)

         # mrj: preambulo
         unidade.mrjs_solicitadas = solicitadas[index+1]
         calculadas = (unidade.eleitorado<=15000? 0 : (unidade.eleitorado/15500.to_f).ceil)

         # mrj: excecoes
         unidade.excecao_mrj = true
         if z == 5 and m == 90646
            atendidas = 4
         elsif z == 21 and m == 90603
            atendidas = 7
         elsif z == 12 and m == 90506 # campo verde, biometria
            atendidas = 2
         elsif z == 36 and m == 90913
            atendidas = 1
         elsif z == 60 and m == 90484
            atendidas = 3
         elsif z == 38 and m == 91553 # sto antonio / serra são vicente
            atendidas = 2
         elsif z == 34 and m == 90590 # chapada
            atendidas = 2
         elsif z == 41 and m == 89893 # araputanga
            atendidas = 1
         elsif z == 42 and m == 90727 # sapezal, uma mesa com 3 urnas em 2010 tiveram 1570 justs
            atendidas = 3
         
         # mrj: nao excecoes
         else      
            unidade.excecao_mrj = false
            atendidas = (solicitadas[index+1]>calculadas ? calculadas : solicitadas[index+1])
         end

         # mrj: variavel atendidas ja tera qtd correta daquela unidade
         unidade.mrjs_atendidas = atendidas
         unidade.mrjs_cadastradas = Mrj.por_eleicao_id(eleicao.id).por_zona(zona.id).por_municipio(mun.id).count # errado, tem que calcular qtas urnas nao somente qtas mrjs
         
         # biometria
         unidade.bio = mun.adjunto.bio # eh bio se municipio for bio
         
         # salva unidade no banco
         unidade.save

         # muda data da geracao da base de logistica         
         eleicao.base_em = DateTime.now
         eleicao.save

      end
   end
   
   def modelo_ues
   
      eleicao = Election.find(params['election']['id'])
      
      # reset as electoral_models
      eleicao.electoral_models.each { |e_model| e_model.destroy }
      # end
      
      # preambulo
      ues_disponiveis = Array.new
      eh_biometrica = Array.new
      ids_modelos = Array.new
      
      ElectronicBallotBoxModel.ativos.each do |modelo| 
         ues_disponiveis << modelo.qtd
         eh_biometrica << (modelo.bio ? true : false)
         ids_modelos << modelo.id
      end
      
      # itera todas as unidades colocando 2 UE2008 pra cada (quarto modelo)
      ElectoralUnit.por_eleicao(eleicao.id).where(:sede => true).each do |un|
      
         e_modelo = ElectoralModel.new
         e_modelo.election_id = eleicao.id
         e_modelo.electoral_unit_id = un.id
         e_modelo.electronic_ballot_box_model_id = ids_modelos[3]
         e_modelo.qtd = 2
         ues_disponiveis[3] -= 2
         e_modelo.save
     
      end
      
      # itera todas as unidades distribuindo
      ElectoralUnit.por_eleicao(eleicao.id).distancia_decrescente.each_with_index do |unidade,index|
      
         urnas_a_enviar = unidade.ues_de_secao + unidade.ues_de_contingencia + unidade.mrjs_atendidas - ElectoralModel.por_eleicao(eleicao.id).por_unidade(unidade.id).sum(:qtd)
         
         #if unidade.sede
         
         #   diferenca_mrjs = ElectoralUnit.por_eleicao(eleicao.id).por_zona(unidade.zone_id).sum(:mrjs_atendidas) - ElectoralUnit.por_eleicao(eleicao.id).por_zona(unidade.zone_id).sum(:mrjs_cadastradas)
            
         #   urnas_a_enviar -= diferenca_mrjs if diferenca_mrjs > 0
         
         #end
         
         modelo = 0
         until urnas_a_enviar == 0 or modelo == ues_disponiveis.size
         
            if (unidade.bio and eh_biometrica[modelo]) or not(unidade.bio)
               urnas_do_modelo = (ues_disponiveis[modelo] >= urnas_a_enviar ? urnas_a_enviar : ues_disponiveis[modelo])
               ues_disponiveis[modelo] -= urnas_do_modelo
               urnas_a_enviar -= urnas_do_modelo
               
               if urnas_do_modelo != 0
                  e_modelo = ElectoralModel.new
                  e_modelo.election_id = eleicao.id
                  e_modelo.electoral_unit_id = unidade.id
                  e_modelo.electronic_ballot_box_model_id = ids_modelos[modelo]
                  e_modelo.qtd = urnas_do_modelo
                  e_modelo.save
               end
            end
               
            modelo += 1            
            
         end
      
      end
     
   end
=begin
      # logistica
      
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

      # logistica de ue         
      log_z["ues_por_modelo"] = Array.new(5) { 0 }
      
      # excecoes
      if z == 5 and m == 90646
         @log_mrj[id][2] = disponibilizadas = 4
      elsif z == 21 and m == 90603
         @log_mrj[id][2] = disponibilizadas = 7
      elsif z == 36 and m == 90913
         @log_mrj[id][2] = disponibilizadas = 1
      elsif z == 60 and m == 90484
         @log_mrj[id][2] = disponibilizadas = 3
      
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


   def distribuicao_ue
     
      @distribuicao_ue = true

      regera_banco_logistica = true
      regera_modelo_ues = true
      @com_nome_chefe = false
      @com_mrj_elo = false
      @com_modelos_ues = true
      
      @eleicao = Election.find(params['election']['id'])
      
      logistica if regera_banco_logistica
      modelo_ues if regera_modelo_ues
      
      # cria adjunct_cities .. Nao executar se ja tiverem sido criadas
      #City.bons.each do |mun|
      #   adj_mun = AdjunctCity.new
      #   adj_mun.city_id = mun.id
      #   adj_mun.kms_de_cuiaba = 0
      #   adj_mun.save
      #end
      
      #Zone.boas.each do |zona|
      #   zona.cities.each do |mun|
      #      Place.por_zid_mid(zona.id,mun.id).each do |local|
      #         adj_local = AdjunctPlace.new
      #         adj_local.numero = local.numero
      #         adj_local.place_id = local.id
      #         adj_local.dificil_acesso = false
      #         adj_local.eletricidade_irregular = false
      #         adj_local.save
      #      end         
      #   end
      #end
      
      #AdjunctPlace.find(:all).each do |adj_local|
      #   adj_local.rural = 1 if adj_local.dificil_acesso or adj_local.eletricidade_irregular
      #   adj_local.save  
      #end
      
      respond_to do |format|
        format.js
        format.html
        format.xls
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
