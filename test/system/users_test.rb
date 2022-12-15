require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
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

     end
     test "Access control" do
     	visit '/login'
     	fill_in "userid", with: "toy"
      	fill_in "Password", with: "toy"
      	click_on "Login"
      	visit '/users'
      	assert_text "ไม่มีสิทธิเข้าถึง"

      	visit '/login'
     	fill_in "userid", with: "Kalos"
      	fill_in "Password", with: "Kalos"
      	click_on "Login"
      	visit '/users'
      	assert_text "ไม่มีสิทธิเข้าถึง"

      	visit '/login'
     	fill_in "userid", with: "Chaos"
      	fill_in "Password", with: "Chaos"
      	click_on "Login"
      	click_on "user_control"
     end

     test "Add user" do
     	visit '/login'
     	fill_in "userid", with: "Chaos"
      	fill_in "Password", with: "Chaos"
      	click_on "Login"
      	click_on "user_control"

      	assert_text "Email: Chaos"
      	assert_text "Name: Chaos"
      	assert_text "User type: admin"

      	click_on "New user"
      	fill_in "user_email", with: "KiritoTester"
      	fill_in "user_name", with: "KiritoTester"
      	fill_in "user_user_type", with: 1
      	fill_in "user_password", with: "KiritoTester"
      	click_on "Create User"
      	assert_text "User was successfully created."
      	click_on "Destroy this user"
      	assert_text "User was successfully destroyed."

      	click_on "New user"
      	fill_in "user_email", with: "KiritoTester"
      	fill_in "user_name", with: "KiritoTester"
      	fill_in "user_user_type", with: 1
      	fill_in "user_password", with: "KiritoTester"
      	click_on "Create User"
      	click_on "Edit this user"
      	fill_in "user_user_type", with: 2
      	click_on "Update User"
      	assert_text "Email: KiritoTester\nName: KiritoTester\nUser type: buyer"
     end
end
