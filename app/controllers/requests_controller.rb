class RequestsController < ApplicationController
  before_filter :require_user
  respond_to :html, :js
  
  # GET /requests
  # GET /requests.xml
  def index
    @contact = current_user.contacts.find(params[:contact_id])
    @requests = @contact.requests

    respond_with @requests
  end

  # GET /requests/1
  # GET /requests/1.xml
  def show
    @contact = current_user.contacts.find(params[:contact_id])
    @request = @contact.requests.find(params[:id])

    respond_with @requests
  end

  # GET /requests/new
  # GET /requests/new.xml
  def new
    @contact = current_user.contacts.find(params[:contact_id])
    @request = @contact.requests.build
    @request.deadline = Date.today

    respond_with @request
  end

  # GET /requests/1/edit
  def edit
    @contact = current_user.contacts.find(params[:contact_id])
    @request = @contact.requests.find(params[:id])
    
    respond_with @request
  end

  # POST /requests
  # POST /requests.xml
  def create
    @contact = current_user.contacts.find(params[:contact_id])
    @request = Request.new(params[:request])
    @request.contact = @contact
    @request.user = current_user

    respond_with @request do |format|
      if @request.save
        @requests = @contact.requests.last_requests
        format.html { redirect_to(contact_requests_path, :notice => t('messages.created')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.xml
  def update
    @contact = current_user.contacts.find(params[:contact_id])
    @request = @contact.requests.find(params[:id])

    respond_with @request do |format|
      if @request.update_attributes(params[:request])
        @requests = @contact.requests.last_requests
        format.html { redirect_to(contact_requests_path, :notice => t('messages.updated')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.xml
  def destroy
    @contact = current_user.contacts.find(params[:contact_id])
    @request = @contact.requests.find(params[:id])
    @request.destroy
    @requests = @contact.requests.last_requests

    respond_with @request do |format|
      format.html { redirect_to(contact_requests_path) }
    end
  end
end
