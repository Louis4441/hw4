class SessionsController < ApplicationController
  def new
  end

  def create
    entered_email = params["email"]
    entered_password = params["password"]
    # we used to use this: @user = User.where({email: entered_email})[0]
    #now - shorter syntax
    @user = User.find_by({ email: entered_email })
        
      if @user # yes, email exists in db
          #check password
          if BCrypt::Password.new(@user.password) == entered_password # if password also matches
              # cookie["user_id"] = @user.id - not as safe as user can change their id in cookies
              # so we use session instead
              session[:user_id] = @user.id
              flash[:notice] == "Welcome!"
              redirect_to "/places"
          else # password doesn't match
              flash[:notice] == "Incorrect password."
              redirect_to "/sessions/new"
          end
      else # email doesn't exist in db
          flash[:notice] == "Email isn't registered"
          redirect_to "/sessions/new"
      end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to "/sessions/new"
  end
end
  