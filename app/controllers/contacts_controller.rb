class ContactsController < ApplicationController
  before_filter :require_user
  respond_to :html, :js
  
  def index
    @search = current_user.contacts.order("name ASC").search(params[:search])
    @contacts = @search.all
    @today_tasks = Task.due_to_today
    @this_week_tasks = Task.due_to_this_week
    @next_week_tasks = Task.due_to_next_week

    respond_with @contacts
  end

  def show
    @contact = current_user.contacts.find(params[:id])
    @contact.update_attribute(:rank, @contact.rank + 1)
    @task = Task.new(:due_at => Time.zone.now.at_midnight)
    @last_tasks = @contact.tasks.last_tasks
    @note = Note.new(:date => Time.zone.now)
    @notes = @contact.notes.last_notes
  end

  def new
    @contact = Contact.new
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.user = current_user

    respond_to do |format|
      if @contact.save
        format.html { redirect_to(@contact, :notice => t('messages.created')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @contact = current_user.contacts.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(@contact, :notice => t('messages.updated')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def favorite
    @contact = current_user.contacts.find(params[:id])

    respond_with @contacts do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(@contact, :notice => t('messages.updated')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy
    @contacts = current_user.contacts.order("name ASC")
    
    respond_with @contacts do |format|
      format.html { redirect_to contacts_path }
    end
  end
  
  def avatar
    @contact = current_user.contacts.find(params[:id])
  end
  
  def confirm_destroy
    @contact = current_user.contacts.find(params[:id])
    render :layout => "confirmation"
  end
  
  def print
    @contacts = current_user.contacts.order("name ASC").find(params[:contact_ids])
    
    respond_to do |format|
      format.html do
        render :layout => "pdf"
      end
      format.pdf do
        render :pdf => I18n.t("application.contacts"), :layout => 'pdf.html.erb', :page_size => "A4",
        :margin => {:top                => 0,
                    :bottom             => 0,
                    :left               => 5,
                    :right              => 5}
      end
    end
  end
end
