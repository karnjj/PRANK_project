require "application_system_test_case"

class MyInventoriesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit my_inventories_url
  #
  #   assert_selector "h1", text: "MyInventory"
  # end

  test "visit my inventory by seller" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    assert_text "My Inventory"
  end

  test "visit my inventory by buyer should not allow" do
    # login as buyer
    user = users(:three)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    assert_text "ไม่มีสิทธิเข้าถึง"
  end

  test "visit my inventory by admin" do
    # login as admin
    user = users(:one)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    assert_text "My Inventory"
  end

  test "visit my inventory & see seller inventory" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    assert_text "My Inventory"
    assert_selector "table"
    assert_selector "tr", count: 4 # 3 item + 1 header
  end

  test "see all inventory item detail" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    assert_text "Image"
    assert_text "Name"
    assert_text "Category"
    assert_text "Price"
    assert_text "Stock"
  end

  test "delete inventory button" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url

    assert_selector "tr", count: 4 # 3 item + 1 header
    # delete item1
    click_on "Delete", match: :first

    assert_selector "tr", count: 3 # 2 item + 1 header
  end

  test "edit inventory button" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    click_on "Edit", match: :first
    assert_text "Edit Item Inventory"
  end

  test "add inventory button" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    click_on "Add Item"
    assert_text "Add Item to Sell"
  end
end
