require 'spec_helper'

describe "Entries searching" do
  context "#index" do
    before do
      @user = FactoryGirl.create(:user)
      ApplicationController.stub(:current_user).and_return(@user)
      FactoryGirl.create(:entry, user_id: @user.id)
      FactoryGirl.create(:entry, user_id: @user.id, body: "Some days it's hard to stick with it.")
    end

    it "should give back search results for entries", js: true do
      visit new_session_path
      fill_in "email", with: @user.email
      fill_in "password", with: "password"
      click_on "Log in"

      expect(page).to have_content("My Journal")

      within "#entry-list-container" do
        expect(page).to have_content("best feeling")
        expect(page).to have_content("Some days it's hard to stick with it.")
      end

      fill_in "entries_search[meetings_search]", with: "best feeling"

      # puts current_url
      # require 'pry'; binding.pry

      within "#entry-list-container" do
        expect(page).to have_content("best feeling")
        # expect(page).to_not have_content("Some days it's hard to stick with it.")
      end

    end
  end
end