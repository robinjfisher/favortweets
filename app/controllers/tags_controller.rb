class TagsController < ApplicationController
  
  def index
    
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    tags = params[:tags].clean_up
    current_user.tag(@tweet, :with => tags, :on => :tags)
    if @tweet.save
      flash[:notice] = "Tags updated"
      redirect_to favorites_path
    else
      flash[:error] = "Could not update tags"
      redirect_to favorites_path
    end
  end

end
