class EntriesController < ApplicationController

  def new
    @current_user = User.find_by({ "id" => session["user_id"] })
    if @current_user == nil
      redirect_to "/login"
  end
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    
    # Assign the logged-in user's ID to this entry
    @entry["user_id"] = session["user_id"] 

    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
