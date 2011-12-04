class NotesController < ApplicationController
  before_filter :require_user
  respond_to :html, :js

  # GET /notes
  # GET /notes.xml
  def index
    @contact = current_user.contacts.find(params[:contact_id])
    @notes = @contact.notes.by_date

    respond_with @notes
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @contact = current_user.contacts.find(params[:contact_id])
    @note = current_user.notes.find(params[:id])
    @comment = @note.comments.new

    respond_with @note
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @contact = current_user.contacts.find(params[:contact_id])
    @note = @contact.notes.build
    @note.date = Time.now

    respond_with @note
  end

  # GET /notes/1/edit
  def edit
    @contact = current_user.contacts.find(params[:contact_id])
    @note = @contact.notes.find(params[:id])

    respond_with @note
  end

  # POST /notes
  # POST /notes.xml
  def create
    @contact = current_user.contacts.find(params[:contact_id])
    @note = Note.new(params[:note])
    @note.contact = @contact
    @note.user = current_user

    respond_with @note do |format|
      if @note.save
        @notes = @contact.notes.last_notes
        format.html { redirect_to(@contact, :notice => t('messages.created')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @contact = current_user.contacts.find(params[:contact_id])
    @note = @contact.notes.find(params[:id])

    respond_with @note do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to([@contact,@note], :notice => t('messages.updated')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @contact = current_user.contacts.find(params[:contact_id])
    @note = @contact.notes.find(params[:id])
    @note.destroy

    respond_with @note do |format|
      format.html { redirect_to(@contact, :notice => t('messages.note.removed')) }
    end
  end
  
  def comment
    @contact = current_user.contacts.find(params[:contact_id])
    @note = @contact.notes.find(params[:id])
    @comment = @note.comments.new(params[:comment])
    @comment.update_attribute(:user_id, current_user)
    
    respond_with @comment do |format|
      format.html { redirect_to([@contact,@note], :notice => t('messages.comment.created')) }
    end
  end
end
