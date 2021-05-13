class CommentsController < ApplicationController
  before_action :authenticate_user

  def new
  end

  def create
    puts "$" * 60
    puts "Inside comments controler:"
    puts params
    puts "$" * 60

    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(content: params[:comment_content], gossip: @gossip)
    @comment.user = User.find_by(id: session[:user_id])

    if @comment.save 
      flash[:Notice] = "Commentaire ajouté avec succès"
      redirect_to @gossip
    else
      flash.now[:notice] = @comment.errors.full_messages

      render :new
      puts "ZZ" * 60
      puts "Probleme:"
      puts params
      puts "ZZ" * 60
    end
  end

  def edit
    @comment = Comment.find(params[:id])

    unless current_user == @comment.user
      flash[:danger] = "Action impossible"
      redirect_to @gossip
    end
  end

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])

    unless current_user == @comment.user
      flash[:danger] = "Action impossible"
      redirect_to @gossip
    end

    if @comment.update(content: params[:comment_content])
      flash[:Notice] = "Commentaire modifié avec succès"
      redirect_to @gossip
    else
      flash.now[:notice] = @gossip.errors.full_messages
      render :edit
    end

  end

  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])

    unless current_user == @comment.user
      flash[:danger] = "Action impossible"
      redirect_to @gossip
    end


    @comment.destroy

    if @comment.destroy
      flash[:Notice] = "Commentaire supprimé avec succès"
      redirect_to @gossip
    else
      flash.now[:notice] = @comment.errors.full_messages
      render @comment
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

