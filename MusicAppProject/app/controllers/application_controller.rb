class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 99 Cats II
  # https://github.com/appacademy/curriculum/blob/master/rails/projects/ninety_nine_cats_ii/solution/app/controllers/application_controller.rb

  # to use in the view make helper methods
  helper_method :current_user
  helper_method :logged_in?


  # code up
  def current_user
      # if the sessions's :session_token is nil that means there couldn't be a current user
      return nil unless session[:session_token] # unless there is some session token on session
      # go into the database + find the user whose session token --> session[:session_token]
      # matches the session's session_token
      # and assign them to current user
      @current_user ||= User.find_by(session_token: session[:session_token])
      # find the user by the token
  end

  # 3
  def login(user)
    # set session, session_token to that users session token -->
    # wrote a helper method in users session token -->
    # generate it, save it and return it
    session[:session_token] = user.reset_session_token
  end

  def logout
    #reset session token on current suer
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  # for views
  def require_login
    # redirect to login form (new session route) unles they are logged in
    redirect_to new_session_url unless logged_in?
  end

end
