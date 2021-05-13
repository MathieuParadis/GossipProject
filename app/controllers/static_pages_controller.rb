class StaticPagesController < ApplicationController
  def team
    puts "$" * 60
    puts "Inside team controller"
    puts "$" * 60
  end

  def contact
    puts "@" * 60
    puts "Inside contact controller"
    puts "@" * 60
  end
end
