require "application_system_test_case"

class TopSellersTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit top_sellers_url
  #
  #   assert_selector "h1", text: "TopSeller"
  # end
  setup do
      a = User.new
      a.email = "kroft"
      a.name = "kroft"
      a.password = "kroft"
      a.user_type = 1
      a.save

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
      y.user_type = 1
      y.save

      s = User.new
      s.email = "toy"
      s.name = "toy"
      s.password = "toy"
      s.user_type = 2
      s.save

      b = items(:one)

      c = Inventory.new
      c.item_id = b.id
      c.seller_id = a.id
      c.user_id = s.id
      c.price = 10
      c.qty = 15
      c.save

      c = Inventory.new
      c.item_id = b.id
      c.seller_id = x.id
      c.user_id = s.id
      c.price = 20
      c.qty = 10
      c.save

    end

    test "no buyer allow" do
      visit "login"
      fill_in "userid", with: "toy"
      fill_in "Password", with: "toy"
      click_on "Login"
      visit "top_seller"
      assert_text "You don't have permission to access this page"
    end
    # Seller ID Seller Name Number of transaction (Quantity) Amount of transaction price (Sales)\n
    test "Sort by qty" do
      a = User.where(email: "kroft")[0]
      b = User.where(email: "Chaos")[0]
      visit "login"
      fill_in "userid", with: "kroft"
      fill_in "Password", with: "kroft"
      click_on "Login"
      click_on "top_seller"
      find('th',text: "Number of transaction").click
      find('th',text: "Number of transaction").click
      assert_text "Seller ID Seller Name Number of transaction (Quantity) Amount of transaction price (Sales)\n#{a.id} kroft 15 10"

      find('th',text: "Amount of transaction price").click
      find('th',text: "Amount of transaction price").click
      assert_text "Seller ID Seller Name Number of transaction (Quantity) Amount of transaction price (Sales)\n#{b.id} Chaos 10 20"

      fill_in "min", with: "December 1st 2022"
      fill_in "max", with: "December 31st 2022"
      assert_text "Seller ID Seller Name Number of transaction (Quantity) Amount of transaction price (Sales)\n#{b.id} Chaos 10 20"

      fill_in "min", with: "December 31st 2022"
      fill_in "max", with: "December 31st 2022"
      assert_text "No data available in table"
    end
end
