class ZonesController < ApplicationController
  # GET /zones
  # GET /zones.json
  def index
    @zones = Zone.mt

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zones }
    end
  end

  # GET /zones/1
  # GET /zones/1.json
  def show
    @zone = Zone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @zone }
    end
  end
end
