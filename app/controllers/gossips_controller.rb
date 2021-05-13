class GossipsController < ApplicationController
  before_action :authenticate_user

  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    @gossips = Gossip.all
    @gossips = @gossips.sort_by {|obj| obj.id}

    @comments = Comment.all
  end

  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    puts "#" * 60
    puts "Inside gossips controller:"
    puts  @gossip_id = params[:id]
    puts "#" * 60
    @gossips = Gossip.all
    @comments = Comment.all
    
    @gossip = @gossips.find(@gossip_id)
    user = User.find_by(id: session[:user_id])
    p @user_likes = Like.where(gossip: @gossip, user: user)
    @like = @user_likes[0]
    
  end

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
    puts "$" * 60
    puts "ceci est le contenu de params :"
    puts params
    puts "$" * 60

    @gossip = Gossip.new(title: params[:gossip_title], content: params[:gossip_content]) 
    @gossip.user = User.find_by(id: session[:user_id])

    if @gossip.save # essaie de sauvegarder en base @gossip
      # si ça marche, il redirige vers la page d'index du site
      flash[:Notice] = "Potin créé avec succès"
      redirect_to :root
    else
      # sinon, il render la view new (qui est celle sur laquelle on est déjà)
      flash.now[:notice] = @gossip.errors.full_messages
      render :new
    end
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip = Gossip.find(params[:id])

    unless current_user == @gossip.user
      flash[:danger] = "Action impossible"
      redirect_to @gossip
    end
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip = Gossip.find(params[:id])

    unless current_user == @gossip.user
      flash[:danger] = "Action impossible"
      redirect_to @gossip
    end

    puts "GO" * 60
    puts "Gossip controller, update method:"
    puts params
    puts "GO" * 60

    if @gossip.update(title: params[:gossip_title], content: params[:gossip_content])
      flash[:Notice] = "Potin modifié avec succès"
      redirect_to @gossip
    else
      flash.now[:notice] = @gossip.errors.full_messages
      render :edit
    end

  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    @gossip = Gossip.find(params[:id])

    unless current_user == @gossip.user
      flash[:danger] = "Action impossible"
      redirect_to @gossip
    end
    
    @gossip.destroy

    puts "GO" * 60
    puts "Gossip controller, destroy method:"
    puts params
    puts "GO" * 60

    if @gossip.destroy
      flash[:Notice] = "Potin supprimé avec succès"
      redirect_to :root
    else
      flash.now[:notice] = "did not work"
      render @gossip
    end
  
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end

