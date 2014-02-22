require 'spec_helper'

describe "Static Pages" do

  context "Navbar" do

    it "sees the dropdown on click", :js => true do
      login
      within(".navbar") do
        expect(page).to_not have_content("The 12 Steps")
        expect(page).to_not have_content("The 12 Traditions")
        expect(page).to_not have_content("The Serenity Prayer")
        expect(page).to_not have_content("The Big Book")
        click_on "Resources"
        expect(page).to have_content("The 12 Steps")
        expect(page).to have_content("The 12 Traditions")
        expect(page).to have_content("The Serenity Prayer")
        expect(page).to have_content("The Big Book")
      end
    end

    it "can view the 12 steps page" do
      login
      within(".navbar") do
        click_on "Resources"
      end
      click_on "The 12 Steps"
      expect(page).to have_content('We admitted we were powerless over alcohol')
      expect(current_path).to eq("/pages/twelve-steps-en")
    end

    it "can view the 12 traditions page" do
      login
      within(".navbar") do
        click_on "Resources"
      end
      click_on "The 12 Traditions"
      expect(page).to have_content('Our common welfare should come first;')
      expect(current_path).to eq("/pages/twelve-traditions-en")
    end

    it "can view the serenity prayer page" do
      login
      within(".navbar") do
        click_on "Resources"
      end
      click_on "The Serenity Prayer"
      expect(page).to have_content('God, give me grace to accept with serenity')
      expect(current_path).to eq("/pages/serenity-prayer-en")
    end

    it "redirects to the big book index page" do
      login
      FactoryGirl.create(:chapter)
      within(".navbar") do
        click_on "Resources"
      end
      click_on "The Big Book"
      expect(page).to have_content('WAR FEVER ran high in the New England town')
      expect(current_path).to eq(big_book_chapters_path)
    end


  end

end