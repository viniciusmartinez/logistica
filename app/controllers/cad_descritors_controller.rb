class CadDescritorsController < ApplicationController
  # GET /cad_descritors
  # GET /cad_descritors.json
  def index
    @cad_descritors = CadDescritor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cad_descritors }
    end
  end

  # GET /cad_descritors/1
  # GET /cad_descritors/1.json
  def show
    @cad_descritor = CadDescritor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cad_descritor }
    end
  end

  # GET /cad_descritors/new
  # GET /cad_descritors/new.json
  def new
    @cad_descritor = CadDescritor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cad_descritor }
    end
  end

  # GET /cad_descritors/1/edit
  def edit
    @cad_descritor = CadDescritor.find(params[:id])
  end

  # POST /cad_descritors
  # POST /cad_descritors.json
  def create
    @cad_descritor = CadDescritor.new(params[:cad_descritor])

    respond_to do |format|
      if @cad_descritor.save
        format.html { redirect_to @cad_descritor, notice: 'Cad descritor was successfully created.' }
        format.json { render json: @cad_descritor, status: :created, location: @cad_descritor }
      else
        format.html { render action: "new" }
        format.json { render json: @cad_descritor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cad_descritors/1
  # PUT /cad_descritors/1.json
  def update
    @cad_descritor = CadDescritor.find(params[:id])

    respond_to do |format|
      if @cad_descritor.update_attributes(params[:cad_descritor])
        format.html { redirect_to @cad_descritor, notice: 'Cad descritor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @cad_descritor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cad_descritors/1
  # DELETE /cad_descritors/1.json
  def destroy
    @cad_descritor = CadDescritor.find(params[:id])
    @cad_descritor.destroy

    respond_to do |format|
      format.html { redirect_to cad_descritors_url }
      format.json { head :ok }
    end
  end
end
