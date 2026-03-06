class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]
    @user["password_digest"] = BCrypt::Password.create(params["password"])
    
    # Attempt to save the user; this will check the uniqueness validations in your User model
    if @user.save
      flash["notice"] = "Thanks for signing up! Please log in."
      redirect_to "/login"
    else
      # If validations fail (e.g., email already taken), redirect back with an alert
      flash["notice"] = "Username or Email already taken. Please try again."
      redirect_to "/users/new"
    end
  end
end