require 'spec_helper'

# TO DO: Learn how to test JavaScript better. This test is evil.

describe "Entries searching" do
  context "#index" do

    xit "should give back search results for entries", js: true do
      visit login_path

      page.execute_script("$('#new_password').show()")
      page.execute_script("$('#new_password_confirmation').show()")
      within "#new_user" do
        fill_in "user[username]", with: "my_username"
        fill_in "user[email]", with: "santa2@northpole.org"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "Sign Up"
      end

      expect(page).to have_content("My Journal")

      click_on "Just Write"
      fill_in "entry[title]", with: "I love being sober! It's the best feeling ever!"
      find("#entry-submit").click

      visit root_path

      click_on "Just Write"
      fill_in "entry[title]", with: "Some days it's hard to stick with it."
      find("#entry-submit").click

      visit root_path

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