class EleCandidatesController < ApplicationController
  # GET /ele_candidates
  # GET /ele_candidates.json
  def index
    @ele_candidates = EleCandidate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ele_candidates }
    end
  end

  # GET /ele_candidates/1
  # GET /ele_candidates/1.json
  def show
    @ele_candidate = EleCandidate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ele_candidate }
    end
  end

  # GET /ele_candidates/new
  # GET /ele_candidates/new.json
  def new
    @ele_candidate = EleCandidate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ele_candidate }
    end
  end

  # GET /ele_candidates/1/edit
  def edit
    @ele_candidate = EleCandidate.find(params[:id])
  end

  # POST /ele_candidates
  # POST /ele_candidates.json
  def create
    @ele_candidate = EleCandidate.new(params[:ele_candidate])

    respond_to do |format|
      if @ele_candidate.save
        format.html { redirect_to @ele_candidate, notice: 'Ele candidate was successfully created.' }
        format.json { render json: @ele_candidate, status: :created, location: @ele_candidate }
      else
        format.html { render action: "new" }
        format.json { render json: @ele_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ele_candidates/1
  # PUT /ele_candidates/1.json
  def update
    @ele_candidate = EleCandidate.find(params[:id])

    respond_to do |format|
      if @ele_candidate.update_attributes(params[:ele_candidate])
        format.html { redirect_to @ele_candidate, notice: 'Ele candidate was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ele_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ele_candidates/1
  # DELETE /ele_candidates/1.json
  def destroy
    @ele_candidate = EleCandidate.find(params[:id])
    @ele_candidate.destroy

    respond_to do |format|
      format.html { redirect_to ele_candidates_url }
      format.json { head :ok }
    end
  end
end
