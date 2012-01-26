class DataelePlacesController < ApplicationController
  # GET /dataele_places
  # GET /dataele_places.json
  def index
    #@dataele_places = DataelePlace.all
    @dataele_places = DataelePlace.find_all_by_zona(2)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataele_places }
    end
  end

  # GET /dataele_places/1
  # GET /dataele_places/1.json
  def show
    @dataele_place = DataelePlace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataele_place }
    end
  end

  # GET /dataele_places/new
  # GET /dataele_places/new.json
  def new
    @dataele_place = DataelePlace.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataele_place }
    end
  end

  # GET /dataele_places/1/edit
  def edit
    @dataele_place = DataelePlace.find(params[:id])
  end

  # POST /dataele_places
  # POST /dataele_places.json
  def create
    @dataele_place = DataelePlace.new(params[:dataele_place])

    respond_to do |format|
      if @dataele_place.save
        format.html { redirect_to @dataele_place, notice: 'Dataele place was successfully created.' }
        format.json { render json: @dataele_place, status: :created, location: @dataele_place }
      else
        format.html { render action: "new" }
        format.json { render json: @dataele_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataele_places/1
  # PUT /dataele_places/1.json
  def update
    @dataele_place = DataelePlace.find(params[:id])

    respond_to do |format|
      if @dataele_place.update_attributes(params[:dataele_place])
        format.html { redirect_to @dataele_place, notice: 'Dataele place was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataele_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataele_places/1
  # DELETE /dataele_places/1.json
  def destroy
    @dataele_place = DataelePlace.find(params[:id])
    @dataele_place.destroy

    respond_to do |format|
      format.html { redirect_to dataele_places_url }
      format.json { head :ok }
    end
  end
end
