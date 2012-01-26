class Ele2012Controller < ApplicationController

   def index
      @zonas = Zone.boas
      @total_municipios = City.bons.size
      @total_locais = 0
      @total_secoes = 0
      @eleicao = ElectionDate.find("Ba1709080617161528") # primeiro turno ele2010
      @total_agregacoes = 0
 
    #@categories = current_user.categories.order("created_at DESC")

    #respond_to do |format|
      #format.html # index.html.erb
      #format.xml  { render :xml => @categories }
    #end
  end

end
