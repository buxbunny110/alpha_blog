class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!session[:user_id]
  end

  def require_user
    if not logged_in?
      flash[:notice] = 'You should be logged in'
      redirect_to(root_path)
    end
  end
end
