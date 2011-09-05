class SiteController < ApplicationController

  def index
    if session[:user]
      flash[:notice] = "Currently logged in as #{current_user.screen_name}. <a href=\"/disconnect\">Not you?</a>"
      redirect_to favorites_path
    end
  end

end
