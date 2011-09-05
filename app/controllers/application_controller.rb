class ApplicationController < ActionController::Base
  
  helper :all
  include UsersHelper
  include ApplicationHelper
  
  helper_method :current_user
  
  protect_from_forgery
  layout 'application'
  
  USER_ID, PASSWORD = "", ""
  
  def current_user
    User.find(session[:user]) unless session[:user].nil?
  end
  
  def logged_in?
    if authenticate_or_request_with_http_basic do |id, password|
      id == USER_ID && password == PASSWORD
    end
      return true
    else
      return false
    end
  end
  
end
