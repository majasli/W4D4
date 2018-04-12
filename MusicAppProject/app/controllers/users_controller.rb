class UsersController < ApplicationController

  # 99 cats
  # https://github.com/appacademy/curriculum/blob/master/rails/projects/ninety_nine_cats_ii/solution/app/controllers/users_controller.rb

  def new
    @user = User.new
    render :new
  end

  def create
    # Users should be logged in immediately after they sign up.
    @user = User.new(user_params)
    if @user.save
      # if create a new user + successfully save
      login(@user)
      # For now just redirect them to a User#show page
      # which simply displays that user's email.
      # users GET    /users(.:format)          users#index
      #       POST   /users(.:format)          users#create
      redirect_to new_session_url
    else
      # if not valid, some validation errors and then render the new template
      flash.now[:errors] = @use.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end


end
