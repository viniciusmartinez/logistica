class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all
  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_admin
      unless current_user.is_admin?
        flash[:notice] = t('application.permission_error')
        redirect_to root_path
        return false
      end
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = t('authlogic.error_messages.require_user')
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = t('authlogic.error_messages.require_no_user')
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end