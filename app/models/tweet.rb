class Tweet < ActiveRecord::Base
  
  belongs_to :user
  acts_as_taggable_on :tags
  after_save :update_taggings_count
  
  scope :untagged, where(:taggings_count => 0)
  scope :tagged, where("tweets.taggings_count > ?", 0)
  
  def update_taggings_count
    count = self.base_tags.size
    Tweet.connection.insert("UPDATE tweets SET taggings_count = #{count} WHERE id = #{self.id}")
  end
  
end
