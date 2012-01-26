class DataeleDescritorsController < ApplicationController
  # GET /dataele_descritors
  # GET /dataele_descritors.json
  def index
    @dataele_descritors = DataeleDescritor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dataele_descritors }
    end
  end

  # GET /dataele_descritors/1
  # GET /dataele_descritors/1.json
  def show
    @dataele_descritor = DataeleDescritor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dataele_descritor }
    end
  end

  # GET /dataele_descritors/new
  # GET /dataele_descritors/new.json
  def new
    @dataele_descritor = DataeleDescritor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dataele_descritor }
    end
  end

  # GET /dataele_descritors/1/edit
  def edit
    @dataele_descritor = DataeleDescritor.find(params[:id])
  end

  # POST /dataele_descritors
  # POST /dataele_descritors.json
  def create
    @dataele_descritor = DataeleDescritor.new(params[:dataele_descritor])

    respond_to do |format|
      if @dataele_descritor.save
        format.html { redirect_to @dataele_descritor, notice: 'Dataele descritor was successfully created.' }
        format.json { render json: @dataele_descritor, status: :created, location: @dataele_descritor }
      else
        format.html { render action: "new" }
        format.json { render json: @dataele_descritor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dataele_descritors/1
  # PUT /dataele_descritors/1.json
  def update
    @dataele_descritor = DataeleDescritor.find(params[:id])

    respond_to do |format|
      if @dataele_descritor.update_attributes(params[:dataele_descritor])
        format.html { redirect_to @dataele_descritor, notice: 'Dataele descritor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dataele_descritor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dataele_descritors/1
  # DELETE /dataele_descritors/1.json
  def destroy
    @dataele_descritor = DataeleDescritor.find(params[:id])
    @dataele_descritor.destroy

    respond_to do |format|
      format.html { redirect_to dataele_descritors_url }
      format.json { head :ok }
    end
  end
end
