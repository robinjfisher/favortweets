module ApplicationHelper
  
  def authenticate_with_twitter
    @config_file = YAML.load_file("#{Rails.root}/config/twitter.yml") rescue nil || {}
    @client = TwitterOAuth::Client.new(
      :consumer_key => @config_file['consumer_key'],
      :consumer_secret => @config_file['consumer_secret']
    )
  end
  
  def connect_to_twitter(user)
    @config_file = YAML.load_file("#{Rails.root}/config/twitter.yml") rescue nil || {}
    Rails.logger.debug("#{@config_file}")
    @client = TwitterOAuth::Client.new(
      :consumer_key => @config_file['consumer_key'],
      :consumer_secret => @config_file['consumer_secret'],
      :token => user.token,
      :secret => user.secret
    )
    Rails.logger.debug("#{@client.authorized?}")
  end
  
end
