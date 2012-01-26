class AggregationHistoriesController < ApplicationController
  # GET /aggregation_histories
  # GET /aggregation_histories.json
  def index
    @aggregation_histories = AggregationHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aggregation_histories }
    end
  end

  # GET /aggregation_histories/1
  # GET /aggregation_histories/1.json
  def show
    @aggregation_history = AggregationHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aggregation_history }
    end
  end

  # GET /aggregation_histories/new
  # GET /aggregation_histories/new.json
  def new
    @aggregation_history = AggregationHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aggregation_history }
    end
  end

  # GET /aggregation_histories/1/edit
  def edit
    @aggregation_history = AggregationHistory.find(params[:id])
  end

  # POST /aggregation_histories
  # POST /aggregation_histories.json
  def create
    @aggregation_history = AggregationHistory.new(params[:aggregation_history])

    respond_to do |format|
      if @aggregation_history.save
        format.html { redirect_to @aggregation_history, notice: 'Aggregation history was successfully created.' }
        format.json { render json: @aggregation_history, status: :created, location: @aggregation_history }
      else
        format.html { render action: "new" }
        format.json { render json: @aggregation_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aggregation_histories/1
  # PUT /aggregation_histories/1.json
  def update
    @aggregation_history = AggregationHistory.find(params[:id])

    respond_to do |format|
      if @aggregation_history.update_attributes(params[:aggregation_history])
        format.html { redirect_to @aggregation_history, notice: 'Aggregation history was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @aggregation_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aggregation_histories/1
  # DELETE /aggregation_histories/1.json
  def destroy
    @aggregation_history = AggregationHistory.find(params[:id])
    @aggregation_history.destroy

    respond_to do |format|
      format.html { redirect_to aggregation_histories_url }
      format.json { head :ok }
    end
  end
end
