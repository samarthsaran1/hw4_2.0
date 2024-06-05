class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"email"=> params["email"]})
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "You are now logged in"
        redirect_to "/places"
      else
        flash["notice"] = "Login not recognized. Please try again"
        redirect_to "/places"
      end
    else
      flash["notice"] = "Login not recognized. Please try again"
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "You are now logged out"
    redirect_to "/login"
  end
end
  