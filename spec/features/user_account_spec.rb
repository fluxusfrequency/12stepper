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

    before do
      @user = FactoryGirl.create(:user, 
        username: "Batman", 
        email: "bwayne@gotham.org")
      @user2 = FactoryGirl.create(:user, 
        username: "Robin", 
        email: "rjblake@gotham.org", 
        last_drink: Date.today - 1.month)
      @user3 = FactoryGirl.create(:user, 
        username: "Joker", 
        email: "jack@gotham.org", 
        last_drink: Date.today)
      FactoryGirl.create(:status, 
        user_id: @user2.id, 
        content: "Kicking ass and taking names!")
      FactoryGirl.create(:friendship, 
        user_id: @user.id, 
        friend_id: @user2.id)
    end

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

    it "can see friends' profiles with their recent posts", js: true do
      account_login

      click_on "Welcome back, Batman!"
      click_on "View My Friends"
      within "#friend-Robin" do
        click_on "View Profile"
      end
      expect(page).to have_content("Robin")
      expect(page).to have_content("days sober!")
      expect(page).to have_content("Robin's Recent Activity")
      within "#recent-activity" do
        expect(page).to have_content("Kicking ass and taking names!")
      end
    end

    it "can see non-friend's profiles, but not their posts", js: true do
      account_login
      click_on "Welcome back, Batman!"

      click_on "Find Friends"
      fill_in "Search for a Friend", with: @user3.username
      page.execute_script("$('#friend-search-form').submit()")
      within "#friend-search-results" do
        within "#search-result-Joker" do
          click_on "View Profile"
        end
      end
      expect(page).to have_content("Joker")
      expect(page).to have_content("1 day sober!")
      expect(page).to_not have_content("Joker's Recent Activity")
    end

  end

  def account_login
    visit login_path(locale: :en)
    page.execute_script("$('#password').show()")
    within "#login-form" do
      fill_in "email", with: @user.email
      fill_in "password", with: "password"
      click_on "Log in"
    end
  end

end
