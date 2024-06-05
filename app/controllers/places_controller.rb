class PlacesController < ApplicationController

  def index
    @places = Place.all
    respond_to do |format|
      format.html
      format.json do 
        render :json => @posts
      end
    end
  end

  def show
    if User.find_by({"id" => session["user_id"]}) != nil
      @place = Place.find_by({ "id" => params["id"] })
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
    else
      flash["notice"] = "Please login before proceeding"   
      redirect_to "/login"
    end
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
