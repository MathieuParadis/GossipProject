class HomeController < ApplicationController
  before_action :authenticate_user

  def index
    puts "@" * 60
    puts "Inside Home controller"
    puts "@" * 60

    @gossips = Gossip.all
    @gossips = @gossips.sort_by {|obj| obj.id}

  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end
