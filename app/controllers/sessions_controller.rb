class SessionsController < ApplicationController
  def new
  end
  
  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    user = User.find_by(email: params[:user_email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe
    if user && user.authenticate(params[:user_password])
      session[:user_id] = user.id
      flash[:Notice] = "Connection réussie"
      redirect_to root_path

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end

  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end

end

