class AddScreenNameAndNameAndProfileImageUrlToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :tweet_user_name, :string
    add_column :tweets, :tweet_user_screen_name, :string
    add_column :tweets, :tweet_user_profile_image_url, :string
  end

  def self.down
    remove_column :tweets, :tweet_user_profile_image_url
    remove_column :tweets, :tweet_user_screen_name
    remove_column :tweets, :tweet_user_name
  end
end
