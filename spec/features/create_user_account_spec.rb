require 'spec_helper'

describe "User Account Creation" do

  context "create an account" do
    before :each do
      visit login_path
    end

    it "a user can reach the sign up page" do
      expect(page).to have_field("Username")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_field("Password Confirmation")
    end

    it "a user with valid information can create an account", js: true do
      page.execute_script("$('#new_password').show()")
      page.execute_script("$('#new_password_confirmation').show()")
      within "#new_user" do
        fill_in "user[username]", with: "Shhhhhh"
        fill_in "user[email]", with: "santa@northpole.org"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        expect{click_on "Sign Up"}.to change{User.count}.by(1)
      end
    end
  end

end
