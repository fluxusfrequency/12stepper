require 'spec_helper'

describe "User Account Creation" do

  context "create an account" do
    before :each do
      visit new_session_path
    end

    it "a user can reach the sign up page" do
      expect(page).to have_field("Username")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_field("Password confirmation")
    end

    it "a user with valid information can create an account" do
      fill_in "Username", with: "Shhhhhh"
      fill_in "user[email]", with: "santa@northpole.org"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      expect{click_on "Create Account"}.to change{User.count}.by(1)
    end
  end


end


