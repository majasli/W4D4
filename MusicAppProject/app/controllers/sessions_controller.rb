class SessionsController < ApplicationController

  # SessionsController#create should re-set the appropriate
  # user's session_token and session[:session_token].

  # 99 cats
  # https://github.com/appacademy/curriculum/blob/master/rails/projects/ninety_nine_cats_ii/solution/app/controllers/sessions_controller.rb

  def new
    render :new
  end

  def create
    # if we succesfuly crate a session redirect to index -- >like the homepage of app
    # also log in user (duh! - your creating a user)
    # find user by credentials by credentials
    # they gave us in the sign in form
    # user model --> coming through a form a user is fillig out
    # as params key into user object in params + draw out user name and draw out password
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    #return valid user or nil
    if @user # if he exists - log them in + redirect to home page
      login(@user)
      # For now just redirect them to a User#show page
      # which simply displays that user's email.
      # users GET    /users(.:format)          users#index
      #       POST   /users(.:format)          users#create
      redirect_to users_url
    else
      # flash some error BUT this time just tell them they have invalid log in credentials
      # in an array .. flash hash takes an array
      # if not successful show them the form again
      flash.now[:errors]  = ["Invalid credentials"]
      render :new
    end
  end

  def destroy
    logout # reset session token + make session token nil
    redirect_to new_session_url
  end
end
