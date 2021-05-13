class UserController < ApplicationController
  def show
    puts "&!" * 60
    puts "Inside user controller:"
    puts  @user_fn = params[:user_first_name]
    puts "&!" * 60

    @users = User.all
    @user = @users.find_by(first_name: @user_fn)

  end
end
