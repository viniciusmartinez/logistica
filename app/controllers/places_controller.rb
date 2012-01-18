class PlacesController < ApplicationController
  # GET /places
  # GET /places.json
  def index
    @places = Place.mt
    #@places = Place.por_municipio(90018)
    #@places = Place.por_zona(21)
    #@places = Zone.find_by_num_zona('39').places # esse fica ordenado pelo mun e nao por city/mun
    #@places = Place.por_zona_municipio(39,90018)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end
end
