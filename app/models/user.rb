class User < ActiveRecord::Base
  
  acts_as_tagger
  has_many :favorites, :class_name => "Tweet", :foreign_key => "user_id"
  
  def self.login_with_twitter
    authenticate_with_twitter
    request_token = @client.request_token(
      :oauth_callback => @config_file['callback_url']
    )
    request_token
  end
  
  private
  
  def self.authenticate_with_twitter
    @config_file = YAML.load_file("#{Rails.root}/config/twitter.yml") rescue nil || {}
    @client = TwitterOAuth::Client.new(
      :consumer_key => @config_file['consumer_key'],
      :consumer_secret => @config_file['consumer_secret']
    )
  end
  
end
