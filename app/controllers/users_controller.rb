class UsersController < ApplicationController
  before_filter :require_user
  before_filter :require_admin, :except => [:profile, :update_profile]
  
  respond_to :html, :js
  
  # GET /users
  # GET /users.xml
  def index
    @users = all_users

    respond_with @users
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => t('messages.created')) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => t('messages.updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @users = all_users
    
    respond_with @users do |format|
      format.html { redirect_to users_path }
    end
  end
  
  def profile
    @user = current_user
  end
  
  def update_profile
    @user = current_user
    
    if @user.update_attributes(params[:user])
      redirect_to(root_path, :notice => t('messages.updated'))
    else
      render :action => "profile"
    end
  end
  
  private
  
  def all_users
    User.order("created_at DESC").search(params[:search]).paginate(:page => params[:page], :per_page => 5)
  end
end
