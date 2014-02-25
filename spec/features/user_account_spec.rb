require 'spec_helper'

describe "User Account Creation" do

  context "create an account" do
    before :each do
      visit login_path(locale: :en)
    end

    it "a user can reach the sign up page", js: true do
      expect(page).to have_field("Username (anonymous)")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_field("Password Confirmation")
    end

    it "a user with valid information can create an account", js: true do
      page.execute_script("$('#new_password').show()")
      page.execute_script("$('#new_password_confirmation').show()")
      within "#new_user" do
        fill_in "user[username]", with: "sinterklaas"
        fill_in "user[email]", with: "santa2@northpole.org"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        fill_in "user[last_drink]", with: "01/01/2010"
        expect{click_on "Sign Up"}.to change{User.count}.by(1)
      end
    end
  end

  context "viewing profile" do
    it "can view its own profile", js: true do
      login
      click_on "Welcome back, SecretSanta!"
      click_on "My Profile"
      within "#user-details" do
        expect(page).to have_content("SecretSanta")
        expect(page).to have_content("1 day sober!")
      end
    end

    it "can edit its details", js: true do
      login
      click_on "Welcome back, SecretSanta!"
      click_on "My Profile"
      click_on "Edit My Profile"
      
      expect(page).to have_content("Edit My Account Details")
      fill_in "user[username]", with: "sinterklaasje"
      fill_in "user[email]", with: "santa2@northpole.org"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      fill_in "user[last_drink]", with: "01/01/2010"
      click_on "Update Profile"
      expect(page).to have_content("Your account details were updated!")
    end
  end

end
