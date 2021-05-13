class LikesController < ApplicationController

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    user = User.find_by(id: session[:user_id])
    @gossip = Gossip.find(params[:gossip_id])
    @user_likes = Like.where(gossip: @gossip, user: user)
  
    @like = Like.new(like: true, user: user, gossip: @gossip)

    if current_user == user && @user_likes.count == 0
      @like.save # essaie de sauvegarder en base @gossip
      # si ça marche, il redirige vers la page d'index du site
      flash[:Notice] = "You liked this gossip"
      redirect_to @gossip

    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      flash.now[:notice] = "Action impossible"
      redirect_to @gossip
    end
  end


  def destroy
    # user = User.find_by(id: session[:user_id])
    # @gossip = Gossip.find(params[:gossip_id])
    # @user_likes = Like.where(gossip: @gossip, user: user)
    # @like = 

    # unless current_user == user && @user_likes.count == 1
    #   flash[:danger] = "Action impossible"
    #   redirect_to @gossip
    # end
    
    # @like = @user_likes[0]
    # @like.destroy

    user = User.find_by(id: session[:user_id])
    @gossip = Gossip.find(params[:gossip_id])
    @user_likes = Like.where(gossip: @gossip, user: user)
  
    # @like = 3

    if current_user == user && @user_likes.count == 1
      @like.destroy # essaie de sauvegarder en base @gossip
      # si ça marche, il redirige vers la page d'index du site
      flash[:Notice] = "You removed your like from this gossip"
      redirect_to @gossip

    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      flash.now[:notice] = "Action impossible"
      redirect_to @gossip
    end

    # if @like.destroy
    #   flash[:Notice] = "Like supprimé avec succès"
    #   redirect_to @gossip
    # else
    #   flash.now[:notice] = "did not work"
    #   render @gossip
    # end
  
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end

