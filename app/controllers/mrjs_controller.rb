class MrjsController < ApplicationController
  # GET /mrjs
  # GET /mrjs.json
  def index
    @mrjs = Mrj.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mrjs }
    end
  end

  # GET /mrjs/1
  # GET /mrjs/1.json
  def show
    @mrj = Mrj.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mrj }
    end
  end

  # GET /mrjs/new
  # GET /mrjs/new.json
  def new
    @mrj = Mrj.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mrj }
    end
  end

  # GET /mrjs/1/edit
  def edit
    @mrj = Mrj.find(params[:id])
  end

  # POST /mrjs
  # POST /mrjs.json
  def create
    @mrj = Mrj.new(params[:mrj])

    respond_to do |format|
      if @mrj.save
        format.html { redirect_to @mrj, notice: 'Mrj was successfully created.' }
        format.json { render json: @mrj, status: :created, location: @mrj }
      else
        format.html { render action: "new" }
        format.json { render json: @mrj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mrjs/1
  # PUT /mrjs/1.json
  def update
    @mrj = Mrj.find(params[:id])

    respond_to do |format|
      if @mrj.update_attributes(params[:mrj])
        format.html { redirect_to @mrj, notice: 'Mrj was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mrj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mrjs/1
  # DELETE /mrjs/1.json
  def destroy
    @mrj = Mrj.find(params[:id])
    @mrj.destroy

    respond_to do |format|
      format.html { redirect_to mrjs_url }
      format.json { head :ok }
    end
  end
end
