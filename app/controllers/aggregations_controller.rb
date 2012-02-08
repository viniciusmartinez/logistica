class AggregationsController < ApplicationController
  # GET /aggregations
  # GET /aggregations.json
  def index
    @aggregations = Aggregation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aggregations }
    end
  end

  # GET /aggregations/1
  # GET /aggregations/1.json
  def show
    @aggregation = Aggregation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aggregation }
    end
  end

  # GET /aggregations/new
  # GET /aggregations/new.json
  def new
    @aggregation = Aggregation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aggregation }
    end
  end

  # GET /aggregations/1/edit
  def edit
    @aggregation = Aggregation.find(params[:id])
  end

  # POST /aggregations
  # POST /aggregations.json
  def create
    @aggregation = Aggregation.new(params[:aggregation])

    respond_to do |format|
      if @aggregation.save
        format.html { redirect_to @aggregation, notice: 'Aggregation was successfully created.' }
        format.json { render json: @aggregation, status: :created, location: @aggregation }
      else
        format.html { render action: "new" }
        format.json { render json: @aggregation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aggregations/1
  # PUT /aggregations/1.json
  def update
    @aggregation = Aggregation.find(params[:id])

    respond_to do |format|
      if @aggregation.update_attributes(params[:aggregation])
        format.html { redirect_to @aggregation, notice: 'Aggregation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @aggregation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aggregations/1
  # DELETE /aggregations/1.json
  def destroy
    @aggregation = Aggregation.find(params[:id])
    @aggregation.destroy

    respond_to do |format|
      format.html { redirect_to aggregations_url }
      format.json { head :ok }
    end
  end
end
