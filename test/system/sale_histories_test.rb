require "application_system_test_case"

class SaleHistoriesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit sale_histories_url
  #
  #   assert_selector "h1", text: "SaleHistory"
  # end
  setup do
    x = User.new
      x.email = "Chaos"
      x.name = "Chaos"
      x.password = "Chaos"
      x.user_type = 1
      x.save

      y = User.new
      y.email = "Kalos"
      y.name = "Kalos"
      y.password = "Kalos"
      y.user_type = 2
      y.save

      b = items(:one)
      d = items(:two)

      c = Inventory.new
      c.item_id = d.id
      c.seller_id = x.id
      c.user_id = y.id
      c.price = 10
      c.qty = 15
      c.save




      d.enable = false
      d.save
      c = Inventory.new
      c.item_id = b.id
      c.seller_id = x.id
      c.user_id = y.id
      c.price = 10
      c.qty = 15
      c.save

      c = Inventory.new
      c.item_id = b.id
      c.seller_id = x.id
      c.user_id = y.id
      c.price = 20
      c.qty = 10
      c.save
  end
  test "visit purchase history & see history" do
    user = users(:three)

    visit "login"
    fill_in "userid", with: "Chaos"
    fill_in "Password", with: "Chaos"
    click_on "Login"
    assert_text "main"

    visit "sale_history"
    assert_text "Sale History"
    assert_selector "table"
    assert_selector "tr", count: 3 + 1 # 2 items + 1 header
  end

  test "see Image Name Category Price Amount Seller Name and Purchase At fields" do
    user = users(:three)

    visit "login"
    fill_in "userid", with: "Chaos"
    fill_in "Password", with: "Chaos"
    click_on "Login"
    assert_text "main"

    visit "sale_history"
    assert_text "Image"
    assert_text "Name"
    assert_text "Category"
    assert_text "Price"
    assert_text "Amount"
    assert_text "Buyer Name"
    assert_text "Sale At"
  end

  test "see item that not enabled" do
    user = users(:three)

    visit "login"
    fill_in "userid", with: "Chaos"
    fill_in "Password", with: "Chaos"
    click_on "Login"
    assert_text "main"

    visit "sale_history"
    assert_selector "td", text: "item2"
  end
end
