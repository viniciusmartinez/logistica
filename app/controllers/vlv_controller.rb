class VlvController < ApplicationController
  before_filter :require_user
  respond_to :html, :js
  
   def index
      @zonas = Zone.boas
      @zona = @zonas.first
      
      @municipios = @zona.cities
      @municipio = @municipios.first
      
      @locais = Place.por_zid_mid(@zona.id, @municipio.id)
      
      @vistorias = ''
   end

   def zona
      @zonas = Zone.boas
      @zona = Zone.find(params[:zone][:id])
      @municipios = @zona.cities
      
      @municipio = @municipios.first
      @locais = Place.por_zid_mid(@zona.id, @municipio.id)
  end
  
  def municipio
  
      Rails.logger.info("PARAMS: #{params.inspect}")
  
      @zonas = Zone.boas
      @zona = Zone.find(params[:zona][:id]) # @zona.id

      @municipios = @zona.cities
      @municipio = City.find(params[:city][:id])
      
      @locais = Place.por_zid_mid(@zona.id, @municipio.id)
  end

end
