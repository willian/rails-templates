class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user, :controller_name, :action_name, :normalized_action_name
  filter_parameter_logging :password, :password_confirmation
  before_filter :set_user_language
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end
 
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to home_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def set_user_language
      I18n.locale = 'pt-BR'
    end

    ### NORMALIZE ACTION NAME #######################################################################
    def normalize_action_name
      normalized_action_name = {
        "new" => "new",
        "create" => "new",
        "edit" => "edit",
        "update" => "edit",
        "destroy" => "destroy",
        "index" => "index",
        "list" => "index"
      }[action_name]
      normalized_action_name || action_name
    end

    def normalized_action_name
      @normalized_action_name ||= normalize_action_name
    end
end
