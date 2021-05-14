class UsersController < ApplicationController
  def show
    puts "&!" * 60
    puts "Inside user controller:"
    puts  @user_id = params[:id]
    puts "&!" * 60

    @users = User.all
    @user = @users.find(@user_id)
  end

  def new
  end

  def create
    puts "$" * 60
    puts "params within users controller, create method :"
    puts params
    puts "$" * 60

    city = City.create(name: "Grenoble", zip_code: "38000")
    @user = User.new(first_name: params[:user_first_name], last_name: params[:user_last_name], age: params[:user_age], email: params[:user_email], password: params[:user_password], password_confirmation: params[:user_password_confirmation], city: city)

    if @user.save 
      # si ça marche, il redirige vers la page d'index du site
      flash[:Notice] = "Utilisateur créé avec succès"
      redirect_to new_session_path
    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      flash.now[:notice] = @user.errors.full_messages
      render :new
    end

  end

end