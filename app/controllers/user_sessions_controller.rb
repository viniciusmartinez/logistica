class UserSessionsController < ApplicationController

  # GET /user_sessions/new
  def new
    @user_session = UserSession.new
  end

  # POST /user_sessions
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { redirect_to(root_path, :notice => t('messages.logged_in')) }
        #format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
      else
        format.html {
          flash.now[:error] = t('messages.login_error')
          render :action => "new"
        }
        #format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      #format.xml  { head :ok }
    end
  end
end