class SurveyProcessesController < ApplicationController
  # GET /survey_processes
  # GET /survey_processes.json
  def index
    @survey_processes = SurveyProcess.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @survey_processes }
    end
  end

  # GET /survey_processes/1
  # GET /survey_processes/1.json
  def show
    @survey_process = SurveyProcess.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey_process }
    end
  end

  # GET /survey_processes/new
  # GET /survey_processes/new.json
  def new
    @survey_process = SurveyProcess.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey_process }
    end
  end

  # GET /survey_processes/1/edit
  def edit
    @survey_process = SurveyProcess.find(params[:id])
  end

  # POST /survey_processes
  # POST /survey_processes.json
  def create
    @survey_process = SurveyProcess.new(params[:survey_process])

    respond_to do |format|
      if @survey_process.save
        format.html { redirect_to @survey_process, notice: 'Survey process was successfully created.' }
        format.json { render json: @survey_process, status: :created, location: @survey_process }
      else
        format.html { render action: "new" }
        format.json { render json: @survey_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /survey_processes/1
  # PUT /survey_processes/1.json
  def update
    @survey_process = SurveyProcess.find(params[:id])

    respond_to do |format|
      if @survey_process.update_attributes(params[:survey_process])
        format.html { redirect_to @survey_process, notice: 'Survey process was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey_process.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_processes/1
  # DELETE /survey_processes/1.json
  def destroy
    @survey_process = SurveyProcess.find(params[:id])
    @survey_process.destroy

    respond_to do |format|
      format.html { redirect_to survey_processes_url }
      format.json { head :ok }
    end
  end
end
