class ApplicationController < ActionController::Base
  # make current user method available in views
  helper_method :current_user, :logged_in?
  
  # return information on the current user
  def current_user
    # if current_user exists, return the variable, else ( @current_user ||= )
    # get user object from users table if session user_id is not nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]      
  end

  # check if a user is logged in
  def logged_in?
    # turn current_user variable into boolean to return true or false
    !!current_user
  end

  # if a user is not logged in display error message and redirect to log in
  def require_login
    if !logged_in?
      flash[:alert] = "You must be logged in to perform this action."
      redirect_to login_path
    end
  end

end
