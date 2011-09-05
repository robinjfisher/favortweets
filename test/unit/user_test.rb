require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    WebMock.disable_net_connect!
  end
  
  test "logging in with twitter should return a token and secret" do
    stub_request(:post, "http://api.twitter.com/oauth/request_token").to_return(:body => "oauth_token=8ldIZyxQeVrFZXFOZH5tAwj6vzJYuLQpl0WUEYtWc&oauth_token_secret=x6qpRnlEmW9JbQn4PQVVeVG8ZLPEx6A0TOebgwcuA&oauth_callback_confirmed=true")
    User.login_with_twitter
    assert_requested :post, "http://api.twitter.com/oauth/request_token"
  end
  
  
  
end
