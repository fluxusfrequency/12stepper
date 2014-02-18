require 'spec_helper'

describe "Static Pages" do

  context "12 Steps" do
    it "can visit the 12 steps page", :js => true do
      user = login
      within("#navbar") do
        expect(page).to_not have_content("The 12 Steps")
        click_on "Resources"
        expect(page).to have_content("The 12 Steps")
      end
    end
  end

end