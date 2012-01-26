class ElectionTypesController < ApplicationController
  # GET /election_types
  # GET /election_types.json
  def index
    @election_types = ElectionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @election_types }
    end
  end

  # GET /election_types/1
  # GET /election_types/1.json
  def show
    @election_type = ElectionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @election_type }
    end
  end

  # GET /election_types/new
  # GET /election_types/new.json
  def new
    @election_type = ElectionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @election_type }
    end
  end

  # GET /election_types/1/edit
  def edit
    @election_type = ElectionType.find(params[:id])
  end

  # POST /election_types
  # POST /election_types.json
  def create
    @election_type = ElectionType.new(params[:election_type])

    respond_to do |format|
      if @election_type.save
        format.html { redirect_to @election_type, notice: 'Election type was successfully created.' }
        format.json { render json: @election_type, status: :created, location: @election_type }
      else
        format.html { render action: "new" }
        format.json { render json: @election_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /election_types/1
  # PUT /election_types/1.json
  def update
    @election_type = ElectionType.find(params[:id])

    respond_to do |format|
      if @election_type.update_attributes(params[:election_type])
        format.html { redirect_to @election_type, notice: 'Election type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @election_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /election_types/1
  # DELETE /election_types/1.json
  def destroy
    @election_type = ElectionType.find(params[:id])
    @election_type.destroy

    respond_to do |format|
      format.html { redirect_to election_types_url }
      format.json { head :ok }
    end
  end
end
