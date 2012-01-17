class CitiesController < ApplicationController
  # GET /cities
  # GET /cities.json
  def index
    @cities = City.mt
    @outros = City.outros
    @desativados = City.desativados

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities }
    end
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    @city = City.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @city }
    end
  end
end
