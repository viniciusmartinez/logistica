class ElectionsController < ApplicationController
  # GET /elections
  # GET /elections.json
  def index
    @elections = Election.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @elections }
    end
  end

  # GET /elections/1
  # GET /elections/1.json
  def show
    @election = Election.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @election }
    end
  end

  # GET /elections/new
  # GET /elections/new.json
  def new
    @election = Election.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @election }
    end
  end

  # GET /elections/1/edit
  def edit
    @election = Election.find(params[:id])
  end

  # POST /elections
  # POST /elections.json
  def create
    @election = Election.new(params[:election])

    respond_to do |format|
      if @election.save
        format.html { redirect_to @election, notice: 'Election was successfully created.' }
        format.json { render json: @election, status: :created, location: @election }
      else
        format.html { render action: "new" }
        format.json { render json: @election.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /elections/1
  # PUT /elections/1.json
  def update
    @election = Election.find(params[:id])

    respond_to do |format|
      if @election.update_attributes(params[:election])
        format.html { redirect_to @election, notice: 'Election was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @election.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elections/1
  # DELETE /elections/1.json
  def destroy
    @election = Election.find(params[:id])
    @election.destroy

    respond_to do |format|
      format.html { redirect_to elections_url }
      format.json { head :ok }
    end
  end
  
   def unidades_eleitorais

      @election = Election.find(params[:id])
     
      @possiveis_unidades = Array.new
      
      Zone.boas.each do |zona|
         zona.municipios.each do |municipio|
            @possiveis_unidades << [zona.id,municipio.id]
         end
      end
  
      @unidades_selecionadas = Array.new(@possiveis_unidades.size)
      
      @unidades_selecionadas.each_with_index { |u,i| @unidades_selecionadas[i] = ElectoralUnit.por_eleicao(@election.id).por_zona(@possiveis_unidades[i][0]).por_municipio(@possiveis_unidades[i][1]).exists? }

   end

   def grava
   
      @election = Election.find(params[:id])
      
      ElectoralUnit.por_eleicao(@election.id).each { |unidade| unidade.destroy }
      
      @possiveis_unidades = Array.new
      Zone.boas.each do |zona|
         zona.municipios.each do |municipio|
            @possiveis_unidades << [zona.id,municipio.id]
         end
      end
      
      params[:unidade].each do |index|
         eu = ElectoralUnit.new
         eu.id = nil
         eu.election_id = @election.id
         eu.zone_id = @possiveis_unidades[index.to_i][0]
         eu.city_id = @possiveis_unidades[index.to_i][1]
         eu.save
      end
      
      #Rails.logger.info("Eleicao: #{params.inspect}")
      
      respond_to do |format|
         format.html { render action: "show" }
      end
   end
  
  
end
