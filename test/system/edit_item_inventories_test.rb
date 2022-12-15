require "application_system_test_case"

class EditItemInventoriesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit edit_item_inventories_url
  #
  #   assert_selector "h1", text: "EditItemInventory"
  # end

  setup do
    @inventory = inventories(:one)
  end

  test "visit edit item inventory by seller" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit edit_item_inventory_url(@inventory)
    assert_text "Edit Item Inventory"
  end

  test "visit edit item inventory by buyer should not allow" do
    # login as buyer
    user = users(:three)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit edit_item_inventory_url(@inventory)
    assert_text "ไม่มีสิทธิเข้าถึง"
  end

  test "visit edit item inventory by admin" do
    # login as admin
    user = users(:one)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit edit_item_inventory_url(@inventory)
    assert_text "Edit Item Inventory"
  end

  test "visit edit item inventory & can edit item inventory" do
    # login as seller
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit edit_item_inventory_url(@inventory)
    assert_text "Edit Item Inventory"

    assert_selector "label", text: "Price"
    assert_selector "label", text: "Stock"
    fill_in "price", with: 1987
    fill_in "stock", with: 3987

    click_on "Save"

    # return to my inventory
    assert_text "My Inventory"

    # check if item inventory is updated
    assert_text "1987"
    assert_text "3987"
  end
end
