class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    
    # Only find entries that belong to this place AND the logged-in user
    @entries = Entry.where({ 
      "place_id" => @place["id"], 
      "user_id" => session["user_id"] 
    })
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end
