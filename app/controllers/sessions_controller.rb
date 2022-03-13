class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ email: params["email"] })
      if @user # email exists in db
          #check password
          if BCrypt::Password.new(@user.password) == params["password"] # if password matches
              session[:user_id] = @user.id
              flash[:notice] = "Welcome, #{@user.username}!"
              redirect_to "/places"
          else # password doesn't match
              flash[:notice] = "Incorrect password."
              redirect_to "/sessions/new"
          end
      else # email doesn't exist in db
          flash[:notice] = "Email isn't registered"
          redirect_to "/sessions/new"
      end
  end

  def destroy
    session["user_id"] = nil
    flash[:notice] = "Logged out"
    redirect_to "/sessions/new"
  end
end
  