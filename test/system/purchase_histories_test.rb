require "application_system_test_case"

class PurchaseHistoriesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit purchase_histories_url
  #
  #   assert_selector "h1", text: "PurchaseHistory"
  # end

  test "visit purchase history by buyer" do
    user = users(:three)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit purchase_history_url
    assert_text "Purchase History"
  end

  test "visit purchase history by seller should not allow" do
    user = users(:two)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit purchase_history_url
    assert_text "ไม่มีสิทธิเข้าถึง"
  end

  test "visit purchase history by admin" do
    user = users(:one)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit purchase_history_url
    assert_text "Purchase History"
  end

  test "visit purchase history & see history" do
    user = users(:three)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit purchase_history_url
    assert_text "Purchase History"
    assert_selector "table"
    assert_selector "tr", count: 2 + 1 # 2 items + 1 header
  end

  test "see Image Name Category Price Amount Seller Name and Purchase At fields" do
    user = users(:three)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit purchase_history_url
    assert_text "Image"
    assert_text "Name"
    assert_text "Category"
    assert_text "Price"
    assert_text "Amount"
    assert_text "Seller Name"
    assert_text "Purchase At"
  end

  test "see item that not enabled" do
    user = users(:three)

    visit "/login"
    fill_in "userid", with: user.email
    fill_in "Password", with: "testpassword"
    click_on "Login"
    assert_text "main"

    visit purchase_history_url
    assert_selector "td", text: "item2"
  end
end
