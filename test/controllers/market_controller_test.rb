require "test_helper"

class MarketControllerTest < ActionDispatch::IntegrationTest
  test "should get my_market" do
    get market_my_market_url
    assert_response :success
  end
end
