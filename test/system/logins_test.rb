require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit logins_url
  #
  #   assert_selector "h1", text: "Login"
  # end
    setup do
      a = User.new
      a.email = "kross"
      a.name = "kross"
      a.password = "kross"
      a.user_type = 0
      a.save

      a = User.new
      a.email = "krof"
      a.name = "krof"
      a.password = "krof"
      a.user_type = 1
      a.save

      a = User.new
      a.email = "toy"
      a.name = "toy"
      a.password = "toy"
      a.user_type = 2
      a.save
    end

    test "visit login / login error" do
      visit "/main/login"
      # check if there is username / password
      assert_selector "label", text: "Username"
      assert_selector "label", text: "Password"
      fill_in "userid", with: "wrong"
      fill_in "Password", with: "wrong"
      click_on "Login"
      assert_text "Username / Password is wrong"
      #expect(page).to have_css("input#password", type: "password")
      #assert_selector "password", type: "password"
    end

    test "login to main & main_option" do
      # admin
      visit "/main/login"
      fill_in "userid", with: "kross"
      fill_in "Password", with: "kross"
      click_on "Login"
      assert_text "main"
      assert_text "profile"
      assert_text "my_market"
      assert_text "purchase_history"
      assert_text "sale_history"
      assert_text "my_inventory"
      assert_text "top_seller"
      assert_text "user_control"
      assert_text "item_control"
      # Seller
      visit "/main/login"
      fill_in "userid", with: "krof"
      fill_in "Password", with: "krof"
      click_on "Login"
      assert_text "main"
      assert_text "profile"
      assert_text "sale_history"
      assert_text "my_inventory"
      assert_text "top_seller"
      # Buyer
      visit "/main/login"
      fill_in "userid", with: "toy"
      fill_in "Password", with: "toy"
      click_on "Login"
      assert_text "main"
      assert_text "profile"
      assert_text "my_market"
      assert_text "purchase_history"
    end

    test "main access control" do
      visit "/main/login"
      visit "/main/main"
      assert_text "Username"
    end

    test "main navigate" do
      # admin
      visit "/main/login"
      fill_in "userid", with: "kross"
      fill_in "Password", with: "kross"
      click_on "Login"
      assert_text "main"

      click_on "profile"
      assert_text "profile"

      visit "/main/main"
      click_on "my_market"
      assert_text "My Market"

      visit "/main/main"
      click_on "purchase_history"
      assert_text "Purchase History"

      visit "/main/main"
      click_on "sale_history"
      assert_text "Sale History"

      visit "/main/main"
      click_on "my_inventory"
      assert_text "My Inventory"

      visit "/main/main"
      click_on "top_seller"
      assert_text "Minimum date"

      # Seller
      visit "/main/login"
      fill_in "userid", with: "krof"
      fill_in "Password", with: "krof"
      click_on "Login"
      assert_text "main"


      click_on "profile"
      assert_text "profile"

      visit "/main/main"
      click_on "sale_history"
      assert_text "Sale History"

      visit "/main/main"
      click_on "my_inventory"
      assert_text "My Inventory"


      visit "/main/main"
      click_on "top_seller"
      assert_text "Minimum date"
      # Buyer
      visit "/main/login"
      fill_in "userid", with: "toy"
      fill_in "Password", with: "toy"
      click_on "Login"
      assert_text "main"

      click_on "profile"
      assert_text "profile"
      
      visit "/main/main"
      click_on "my_market"
      assert_text "My Market"
      
      visit "/main/main"
      click_on "purchase_history"
      assert_text "Purchase History"
    end
end
