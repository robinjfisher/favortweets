class TweetsController < ApplicationController
  
  def index
    case params[:category]
    when "untagged"
      @tweets = current_user.favorites.untagged.order('tweet_created_at DESC').all
      @untagged = true
    when "tagged"
      @tweets = current_user.favorites.tagged.order('tweet_created_at DESC').all
      @tagged = true
    else
      @tweets = current_user.favorites.order('tweet_created_at DESC').all
      @all = true
    end
    taggings = ActsAsTaggableOn::Tagging.where("tagger_id = ?", current_user.id)
    @tags = taggings.collect{ |t| t.tag }
  end
  
  def tag
    @tweets = Tweet.tagged_with(params[:tag], :on => :tags)
    taggings = ActsAsTaggableOn::Tagging.where("tagger_id = ?", current_user.id)
    @tags = taggings.collect{ |t| t.tag }
    @tagged = true
    render :index
  end
  
  def synchronise
    connect_to_twitter(current_user)
    current_favorites = current_user.favorites.all
    ft_ids = Array.new
    tw_ids = Array.new
    Rails.logger.debug("Init arrays")
    current_favorites.each do |f|
      ft_ids << f.tweet_id
    end
    favorites = @client.favorites
    Rails.logger.debug("#{favorites}")
    hashed = Hash.new
    favorites.each do |f|
      id = f['id'].to_s
      hashed[id] = f
    end
    favorites.each do |f|
      tw_ids << f['id'].to_s
    end
    ft_ids.each do |i|
      unless tw_ids.include?(i)
        Tweet.find_by_tweet_id(i.to_i).destroy
      end
    end
    tw_ids.each do |i|
      unless ft_ids.include?(i)
        f = hashed[i.to_s]
        Tweet.create(:user_id => current_user.id, :tweet_id => f['id'], :tweet_text => f['text'], :tweet_created_at => f['created_at'],
        :tweet_user_name => f['user']['name'], :tweet_user_screen_name => f['user']['screen_name'], :tweet_user_profile_image_url => f['user']['profile_image_url'])
      end
    end
    redirect_to favorites_url
  end
  
end
