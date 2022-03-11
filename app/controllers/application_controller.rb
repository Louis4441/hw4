class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    if session["user_id"]
      @current_user = User.find(session["user_id"]) # sets variable for use anywhere in the app
    end
  end
end
