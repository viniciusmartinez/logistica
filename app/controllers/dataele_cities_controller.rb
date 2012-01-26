class DataeleCitiesController < ApplicationController
  # GET /dataele_cities
  # GET /dataele_cities.json
  def index
    @dataele_cities = DataeleCity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataele_cities }
    end
  end

  # GET /dataele_cities/1
  # GET /dataele_cities/1.json
  def show
    @dataele_city = DataeleCity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataele_city }
    end
  end

  # GET /dataele_cities/new
  # GET /dataele_cities/new.json
  def new
    @dataele_city = DataeleCity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataele_city }
    end
  end

  # GET /dataele_cities/1/edit
  def edit
    @dataele_city = DataeleCity.find(params[:id])
  end

  # POST /dataele_cities
  # POST /dataele_cities.json
  def create
    @dataele_city = DataeleCity.new(params[:dataele_city])

    respond_to do |format|
      if @dataele_city.save
        format.html { redirect_to @dataele_city, notice: 'Dataele city was successfully created.' }
        format.json { render json: @dataele_city, status: :created, location: @dataele_city }
      else
        format.html { render action: "new" }
        format.json { render json: @dataele_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataele_cities/1
  # PUT /dataele_cities/1.json
  def update
    @dataele_city = DataeleCity.find(params[:id])

    respond_to do |format|
      if @dataele_city.update_attributes(params[:dataele_city])
        format.html { redirect_to @dataele_city, notice: 'Dataele city was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataele_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataele_cities/1
  # DELETE /dataele_cities/1.json
  def destroy
    @dataele_city = DataeleCity.find(params[:id])
    @dataele_city.destroy

    respond_to do |format|
      format.html { redirect_to dataele_cities_url }
      format.json { head :ok }
    end
  end
end
