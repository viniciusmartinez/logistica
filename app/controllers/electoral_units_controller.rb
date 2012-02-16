class ElectoralUnitsController < ApplicationController
  # GET /electoral_units
  # GET /electoral_units.json
  def index
    @electoral_units = ElectoralUnit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @electoral_units }
    end
  end

  # GET /electoral_units/1
  # GET /electoral_units/1.json
  def show
    @electoral_unit = ElectoralUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @electoral_unit }
    end
  end

  # GET /electoral_units/new
  # GET /electoral_units/new.json
  def new
    @electoral_unit = ElectoralUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @electoral_unit }
    end
  end

  # GET /electoral_units/1/edit
  def edit
    @electoral_unit = ElectoralUnit.find(params[:id])
  end

  # POST /electoral_units
  # POST /electoral_units.json
  def create
    @electoral_unit = ElectoralUnit.new(params[:electoral_unit])

    respond_to do |format|
      if @electoral_unit.save
        format.html { redirect_to @electoral_unit, notice: 'Electoral unit was successfully created.' }
        format.json { render json: @electoral_unit, status: :created, location: @electoral_unit }
      else
        format.html { render action: "new" }
        format.json { render json: @electoral_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /electoral_units/1
  # PUT /electoral_units/1.json
  def update
    @electoral_unit = ElectoralUnit.find(params[:id])

    respond_to do |format|
      if @electoral_unit.update_attributes(params[:electoral_unit])
        format.html { redirect_to @electoral_unit, notice: 'Electoral unit was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @electoral_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /electoral_units/1
  # DELETE /electoral_units/1.json
  def destroy
    @electoral_unit = ElectoralUnit.find(params[:id])
    @electoral_unit.destroy

    respond_to do |format|
      format.html { redirect_to electoral_units_url }
      format.json { head :ok }
    end
  end
end
