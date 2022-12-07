require "test_helper"

class InventoryControllerTest < ActionDispatch::IntegrationTest
  test "should get my_inventory" do
    get inventory_my_inventory_url
    assert_response :success
  end
end
