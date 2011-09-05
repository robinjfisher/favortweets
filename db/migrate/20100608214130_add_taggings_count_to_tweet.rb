class AddTaggingsCountToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :taggings_count, :integer, :default => 0
  end

  def self.down
    remove_column :tweets, :taggings_count
  end
end
