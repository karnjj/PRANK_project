require "application_system_test_case"

class AddItemToSellsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit add_item_to_sells_url
  #
  #   assert_selector "h1", text: "AddItemToSell"
  # end

  setup do
    market = markets(:one)
    market.destroy
  end

  test "visit add item to sell by seller" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit add_item_to_sell_url
    assert_text "Add Item to Sell"
  end

  test "visit add item to sell by buyer should not allow" do
    # login as buyer
    user = users(:three)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit add_item_to_sell_url
    assert_text "ไม่มีสิทธิเข้าถึง"
  end

  test "visit add item to sell by admin" do
    # login as admin
    user = users(:one)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit add_item_to_sell_url
    assert_text "Add Item to Sell"
  end

  test "visit add item to sell & can add item to sell" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_inventory_url
    assert_no_selector "td", text: "item1"

    visit add_item_to_sell_url
    assert_text "Add Item to Sell"

    item = Item.find_by(name: "item1")

    choose("item_id_#{item.id}")

    fill_in "price", with: 1987
    fill_in "stock", with: 3987

    click_on "Add"

    # return to my inventory
    assert_text "My Inventory"

    # check if item inventory is added
    assert_selector "td", text: "item1"
    assert_text "1987"
    assert_text "3987"
  end
end
