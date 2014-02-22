require 'spec_helper'

describe "User Authentication" do

  context "logging in" do
    it "can login with username and valid password" do
      user = login
      expect(current_path).to eq(root_path)
      expect(page).to_not have_content "Our Support."
      expect(page).to_not have_content "Your Success."
    end
  end

  context "logging out" do
    it "can logout" do
      user = login
      expect(page).to_not have_content "Our Support."
      expect(page).to_not have_content "Your Success."
      click_on "Welcome back, SecretSanta!"
      expect(page).to have_content "Logout"
      click_on "Logout"
      
      expect(page).to have_content "Our Support."
      expect(page).to have_content "Your Success."

      expect(current_path).to eq(new_session_path)
    end
  end

end


