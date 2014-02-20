require 'spec_helper'

describe "Entries searching" do
  context "#index" do
    before do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:entry, user_id: user.id)
      FactoryGirl.create(:entry, user_id: user.id, body: "Some days it's hard to stick with it.")
    end

    it "should give back search results for entries", js: true do
      visit '/'
      click_on "Login"
      fill_in "Email", with: User.first.email
      fill_in "Password", with: "password"
      click_on "Log in"

      expect(page).to have_content("My Journal")

      within "#entry-list-container" do
        expect(page).to have_content("best feeling")
        expect(page).to have_content("Some days it's hard to stick with it.")
      end

      fill_in "entries_search[meetings_search]", with: "best feeling"

      within "#entry-list-container" do
        expect(page).to have_content("best feeling")
        expect(page).to_not have_content("Some days it's hard to stick with it.")
      end

    end
  end
end