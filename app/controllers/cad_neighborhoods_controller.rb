class CadNeighborhoodsController < ApplicationController
  # GET /cad_neighborhoods
  # GET /cad_neighborhoods.json
  def index
    @cad_neighborhoods = CadNeighborhood.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cad_neighborhoods }
    end
  end

  # GET /cad_neighborhoods/1
  # GET /cad_neighborhoods/1.json
  def show
    @cad_neighborhood = CadNeighborhood.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cad_neighborhood }
    end
  end

  # GET /cad_neighborhoods/new
  # GET /cad_neighborhoods/new.json
  def new
    @cad_neighborhood = CadNeighborhood.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cad_neighborhood }
    end
  end

  # GET /cad_neighborhoods/1/edit
  def edit
    @cad_neighborhood = CadNeighborhood.find(params[:id])
  end

  # POST /cad_neighborhoods
  # POST /cad_neighborhoods.json
  def create
    @cad_neighborhood = CadNeighborhood.new(params[:cad_neighborhood])

    respond_to do |format|
      if @cad_neighborhood.save
        format.html { redirect_to @cad_neighborhood, notice: 'Cad neighborhood was successfully created.' }
        format.json { render json: @cad_neighborhood, status: :created, location: @cad_neighborhood }
      else
        format.html { render action: "new" }
        format.json { render json: @cad_neighborhood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cad_neighborhoods/1
  # PUT /cad_neighborhoods/1.json
  def update
    @cad_neighborhood = CadNeighborhood.find(params[:id])

    respond_to do |format|
      if @cad_neighborhood.update_attributes(params[:cad_neighborhood])
        format.html { redirect_to @cad_neighborhood, notice: 'Cad neighborhood was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @cad_neighborhood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cad_neighborhoods/1
  # DELETE /cad_neighborhoods/1.json
  def destroy
    @cad_neighborhood = CadNeighborhood.find(params[:id])
    @cad_neighborhood.destroy

    respond_to do |format|
      format.html { redirect_to cad_neighborhoods_url }
      format.json { head :ok }
    end
  end
end
