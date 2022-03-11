class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params["user"])
    # add encryption of te password here
    # params["user"]:
    # {"first_name"=>"Louis", "last_name"=>"Harel", "email"=>"harel.louis@gmail.com", "password"=>"tacos"}
    # params["user"]["password"] => "tacos"
    plain_text_password = params["user"]["password"]
    @user.password = BCrypt::Password.create(plain_text_password)
    @user.save
    redirect_to "/"
  end
end
