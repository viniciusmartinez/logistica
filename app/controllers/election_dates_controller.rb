class ElectionDatesController < ApplicationController
  # GET /election_dates
  # GET /election_dates.json
  def index
    @election_dates = ElectionDate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @election_dates }
    end
  end

  # GET /election_dates/1
  # GET /election_dates/1.json
  def show
    @election_date = ElectionDate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @election_date }
    end
  end

  # GET /election_dates/new
  # GET /election_dates/new.json
  def new
    @election_date = ElectionDate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @election_date }
    end
  end

  # GET /election_dates/1/edit
  def edit
    @election_date = ElectionDate.find(params[:id])
  end

  # POST /election_dates
  # POST /election_dates.json
  def create
    @election_date = ElectionDate.new(params[:election_date])

    respond_to do |format|
      if @election_date.save
        format.html { redirect_to @election_date, notice: 'Election date was successfully created.' }
        format.json { render json: @election_date, status: :created, location: @election_date }
      else
        format.html { render action: "new" }
        format.json { render json: @election_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /election_dates/1
  # PUT /election_dates/1.json
  def update
    @election_date = ElectionDate.find(params[:id])

    respond_to do |format|
      if @election_date.update_attributes(params[:election_date])
        format.html { redirect_to @election_date, notice: 'Election date was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @election_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /election_dates/1
  # DELETE /election_dates/1.json
  def destroy
    @election_date = ElectionDate.find(params[:id])
    @election_date.destroy

    respond_to do |format|
      format.html { redirect_to election_dates_url }
      format.json { head :ok }
    end
  end
end
