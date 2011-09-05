class AddIndexesOnTweetTableAndUserTable < ActiveRecord::Migration
  def self.up
    change_table :tweets do |t|
      t.index :tweet_id
      t.index :user_id
    end
    
    change_column :users, :twitter_id, :string
    
    change_table :users do |t|
      t.index :screen_name
      t.index :twitter_id
    end
  end

  def self.down
  end
end
