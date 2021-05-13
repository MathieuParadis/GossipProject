class CitiesController < ApplicationController
  def show
    puts "&!" * 60
    puts "Inside city controller:"
    puts  @city_id = params[:id]
    puts "&!" * 60
    
    @cities = City.all
    @city = @cities.find(@city_id)
  end

end

