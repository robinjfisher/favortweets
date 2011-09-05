class UsersController < ApplicationController
  
  rescue_from Net::HTTPFatalError, :with => :twitter_down
  
  def connect
    request_token = User.login_with_twitter
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url.gsub('authorize', 'authenticate')
  end
  
  def disconnect
    session[:user] = nil
    session[:request_token] = nil
    session[:request_token_secret] = nil
    redirect_to root_url
  end
  
  def auth
    begin
      authenticate_with_twitter
      @access_token = @client.authorize(
      session[:request_token],
      session[:request_token_secret],
      :oauth_verifier => params[:oauth_verifier]
    )
      rescue OAuth::Unauthorized
    end

    if @client.authorized?
      Rails.logger.debug("#{@access_token.inspect}")
      response = @client.info
      user = response['screen_name']
      unless @user = User.find_by_screen_name(user)
        @user = User.create(:token => @access_token.token, :secret => @access_token.secret,
        :screen_name => response['screen_name'], :twitter_id => response['id'], :name => response['name'])
        flash[:notice] = "Thanks for registering with Favourtweets!"
      end
      session[:user] = @user.id
      flash[:notice] = "Hello again!"
      redirect_to '/favorites/all'
    else
      flash[:error] = "Yikes! You need to login with your Twitter account to use Favourtweets"
      redirect_to '/'
    end
  end
  
  private
  
  def twitter_down
    render :text => "Aaargh, Twitter is down and that means you can't login at the moment.", :status => 503
  end
  
end
