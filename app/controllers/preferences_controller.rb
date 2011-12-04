class PreferencesController < ApplicationController
  before_filter :require_user
  
  def index
    @user = current_user
    @user.build_preference unless @user.preference
    @preference = @user.preference
  end

  def create
    @preference = Preference.new(params[:preference])
    @preference.user = current_user

    if @preference.save
      redirect_to(preferences_path, :notice => t('messages.created'))
    else
      render :action => "new"
    end
  end

  def update
    @preference = Preference.find(params[:id])

    if @preference.update_attributes(params[:preference])
      redirect_to(preferences_path, :notice => t('messages.updated'))
    else
      render :action => "edit"
    end
  end
  
  def dashboard
    @user = current_user
    @user.build_preference unless @user.preference
    @preference = @user.preference
  end
  
  def update_dashboard
    @user = current_user
    @user.build_preference unless @user.preference
    @preference = @user.preference
    
    if @preference.update_attributes(params[:preference])
      redirect_to(dashboard_preferences_path, :notice => t('messages.updated'))
    else
      render :action => "dashboard"
    end
  end

end
