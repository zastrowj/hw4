class SessionsController < ApplicationController
  def new
    # This remains empty because it just shows the form
  end

  def create
    # Find the user by the email entered in the form
    @user = User.find_by({ "email" => params["email"] })

    # If the user exists in the database...
    if @user != nil
      # ...check if the password they typed matches the one in the database
      if @user.authenticate(params["password"])
        # Log them in by saving their ID in the session
        session["user_id"] = @user["id"]
        
        flash["notice"] = "Welcome."
        redirect_to "/places"
      else
        # Wrong password
        flash["notice"] = "Nope."
        redirect_to "/login"
      end
    else
      # Email not found
      flash["notice"] = "Nope."
      redirect_to "/login"
    end
  end

  def destroy
    # Log the user out by clearing the session
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end