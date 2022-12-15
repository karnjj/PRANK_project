require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit logins_url
  #
  #   assert_selector "h1", text: "Login"
  # end
    test "visit login" do
      visit "/main/login"
      # check if there is username / password
      assert_selector "label", text: "Username"
      assert_selector "label", text: "Password"
      fill_in "userid", with: "test"
      fill_in "Password", with: "test"
      #expect(page).to have_css("input#password", type: "password")
      #assert_selector "password", type: "password"

    end
end
