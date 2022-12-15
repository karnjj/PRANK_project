require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    x = User.new
    x.email = "Chaos"
    x.name = "Chaos"
    x.password = "Chaos"
    x.user_type = 0
    x.save
    y = User.new
    y.email = "Kalos"
    y.name = "Kalos"
    y.password = "Kalos"
    y.user_type = 1
    y.save

    s = User.new
    s.email = "toy"
    s.name = "toy"
    s.password = "toy"
    s.user_type = 2
    s.save
    @item = items(:one)
  end

  test "Access control" do
      visit '/login'
      fill_in "userid", with: "toy"
      fill_in "Password", with: "toy"
      click_on "Login"
      visit items_url
      assert_text "ไม่มีสิทธิเข้าถึง"

      visit '/login'
      fill_in "userid", with: "Kalos"
      fill_in "Password", with: "Kalos"
      click_on "Login"
      visit items_url
      assert_text "ไม่มีสิทธิเข้าถึง"
  end

  test "visiting the index" do
    visit '/login'
    fill_in "userid", with: "Chaos"
    fill_in "Password", with: "Chaos"
    click_on "Login"
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "should create item" do
    visit '/login'
    fill_in "userid", with: "Chaos"
    fill_in "Password", with: "Chaos"
    click_on "Login"
    visit items_url
    click_on "New item"

    fill_in "Category", with: @item.category
    check "Enable" if @item.enable
    fill_in "Name", with: @item.name
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "should update Item" do
    visit '/login'
    fill_in "userid", with: "Chaos"
    fill_in "Password", with: "Chaos"
    click_on "Login"
    visit item_url(@item)
    click_on "Edit this item", match: :first

    fill_in "Category", with: @item.category
    check "Enable" if @item.enable
    fill_in "Name", with: @item.name
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "should destroy Item" do
    visit '/login'
    fill_in "userid", with: "Chaos"
    fill_in "Password", with: "Chaos"
    click_on "Login"

    visit items_url
    click_on "New item"

    fill_in "Category", with: @item.category
    check "Enable" if @item.enable
    fill_in "Name", with: "Kaikolos's Sword"
    click_on "Create Item"

    assert_text "Item was successfully created"

    click_on "Destroy this item"

    assert_text "Item was successfully destroyed"

    visit "add_item_to_sell"
    assert_no_text "Kaikolos's Sword"
  end
end
