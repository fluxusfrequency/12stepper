require 'spec_helper'

describe "Static Pages" do

  context "Navbar" do

    it "sees the dropdown on click", :js => true do
      login
      within("#navbar") do
        expect(page).to_not have_content("The 12 Steps")
        expect(page).to_not have_content("The 12 Traditions")
        expect(page).to_not have_content("The Serenity Prayer")
        click_on "Resources"
        expect(page).to have_content("The 12 Steps")
        expect(page).to have_content("The 12 Traditions")
        expect(page).to have_content("The Serenity Prayer")
      end
    end


  end

end