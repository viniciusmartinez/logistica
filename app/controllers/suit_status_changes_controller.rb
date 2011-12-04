class SuitStatusChangesController < ApplicationController
  # GET /suit_status_changes
  # GET /suit_status_changes.xml
  def index
    @suit_status_changes = SuitStatusChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @suit_status_changes }
    end
  end

  # GET /suit_status_changes/1
  # GET /suit_status_changes/1.xml
  def show
    @suit_status_change = SuitStatusChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @suit_status_change }
    end
  end

  # GET /suit_status_changes/new
  # GET /suit_status_changes/new.xml
  def new
    @suit_status_change = SuitStatusChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @suit_status_change }
    end
  end

  # GET /suit_status_changes/1/edit
  def edit
    @suit_status_change = SuitStatusChange.find(params[:id])
  end

  # POST /suit_status_changes
  # POST /suit_status_changes.xml
  def create
    @suit_status_change = SuitStatusChange.new(params[:suit_status_change])

    respond_to do |format|
      if @suit_status_change.save
        format.html { redirect_to(@suit_status_change, :notice => 'Suit status change was successfully created.') }
        format.xml  { render :xml => @suit_status_change, :status => :created, :location => @suit_status_change }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @suit_status_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /suit_status_changes/1
  # PUT /suit_status_changes/1.xml
  def update
    @suit_status_change = SuitStatusChange.find(params[:id])

    respond_to do |format|
      if @suit_status_change.update_attributes(params[:suit_status_change])
        format.html { redirect_to(@suit_status_change, :notice => 'Suit status change was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @suit_status_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /suit_status_changes/1
  # DELETE /suit_status_changes/1.xml
  def destroy
    @suit_status_change = SuitStatusChange.find(params[:id])
    @suit_status_change.destroy

    respond_to do |format|
      format.html { redirect_to(suit_status_changes_url) }
      format.xml  { head :ok }
    end
  end
end
