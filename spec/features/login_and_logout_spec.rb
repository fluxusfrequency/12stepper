require 'spec_helper'

describe "User Authentication" do

  context "logging in" do
    it "can login with username and valide password" do
      user = login
      expect(current_path).to eq(user_path(user, locale: :en))
      within("#navbar") do
        expect(page).to_not have_content "Login"
        expect(page).to_not have_content "Sign Up"
      end
    end
  end

  context "logging out" do
    it "can logout" do
      user = login
      within("#navbar") do
        expect(page).to_not have_content "Login"
        expect(page).to_not have_content "Sign Up"
        expect(page).to have_content "Logout"
        click_on "Logout"
      end
      within("#navbar") do
        expect(page).to have_content "Login"
        expect(page).to have_content "Sign Up"
      end

      expect(current_path).to eq(root_path)
    end
  end

end


