require "application_system_test_case"

class MyMarketsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit my_markets_url
  #
  #   assert_selector "h1", text: "MyMarket"
  # end

  test "visit my market by buyer" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url
    assert_text "My Market"
  end

  test "visit my market by seller" do
    # login as seller
    user = users(:two)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url
    assert_text "ไม่มีสิทธิเข้าถึง"
  end

  test "visit my market by admin" do
    # login as admin
    user = users(:one)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url
    assert_text "My Market"
  end

  test "visit my market & see market" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url
    assert_text "My Market"
    assert_selector "table"
    assert_selector "tr", count: 2 + 1 # 2 items + 1 header
  end

  test "see all market item detail" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url
    assert_text "Image"
    assert_text "Name"
    assert_text "Category"
    assert_text "Price"
    assert_text "Stock"
  end

  test "search by category" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url
    assert_selector "tr", count: 2 + 1 # 2 items + 1 header
    assert_selector "td", text: "categoryA"
    assert_selector "td", text: "categoryB"

    # test search by category
    fill_in "Search By Category:", with: "category"

    assert_selector "tr", count: 2 + 1 # 1 item + 1 header
    assert_selector "td", text: "categoryA"
    assert_selector "td", text: "categoryB"

    # test search by categoryA
    fill_in "Search By Category:", with: "categoryA"

    assert_selector "tr", count: 1 + 1 # 1 item + 1 header
    assert_selector "td", text: "categoryA"
    assert_no_selector "td", text: "categoryB"

    # test search by categoryB
    fill_in "Search By Category:", with: "categoryB"

    assert_selector "tr", count: 1 + 1 # 1 item + 1 header
    assert_selector "td", text: "categoryB"
    assert_no_selector "td", text: "categoryA"
  end

  test "hide market item if stock equal to zero" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url
    assert_selector "tr", count: 2 + 1 # 2 items + 1 header
    assert_selector "td", text: "item1"
    assert_selector "td", text: "item3"

    # set stock to zero
    market = Market.joins(:item).find_by("items.name = 'item1'")
    market.stock = 0
    market.save

    visit my_market_url
    assert_selector "tr", count: 1 + 1 # 1 item + 1 header
    assert_no_selector "td", text: "item1"
    assert_selector "td", text: "item3"
  end

  test "no error if no item in market" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    # delete all market item
    Market.destroy_all

    visit my_market_url
    assert_text "My Market"
    assert_selector "table"
  end

  test "buy item" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url

    market = Market.joins(:item).find_by("items.name = 'item3'")

    # buy item3
    within "tr#market-item-#{market.id}" do
      assert_selector "td:nth-child(2)", text: "item3"
      assert_selector "td:nth-child(5)", text: "3"
      fill_in "amount", with: "1"
      click_button "Buy"
    end

    visit my_market_url

    within "tr#market-item-#{market.id}" do
      assert_selector "td:nth-child(2)", text: "item3"
      assert_selector "td:nth-child(5)", text: "2"
    end
  end

  test "buy more item than stock has" do
    # login as buyer
    user = users(:three)
    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit my_market_url

    market = Market.joins(:item).find_by("items.name = 'item3'")

    # buy item3
    within "tr#market-item-#{market.id}" do
      assert_selector "td:nth-child(2)", text: "item3"
      assert_selector "td:nth-child(5)", text: "3"
      fill_in "amount", with: "5"
      click_button "Buy"
    end

    assert_text "จำนวนสินค้ามีไม่พอ"
  end
end
