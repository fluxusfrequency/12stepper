require 'spec_helper'

describe "Big Book" do
  context "#index" do

    before do
      FactoryGirl.create(:chapter)
    end

    it "sees the table of contents and first chapter" do
      login
      visit big_book_chapters_path
      expect(page).to have_content("Table of Contents")
      expect(page).to have_content("WAR FEVER ran high in the New England town to which we new, young officers from Plattsburg were assigned")
    end
  end

  context '#show' do
    before do
      FactoryGirl.create(:chapter)
      FactoryGirl.create(:chapter, 
        chapter_number: 2, 
        title: "THERE IS A SOLUTION", 
        body: "WE, OF ALCOHOLICS ANONYMOUS, know thousands of men and women...")
    end

    it "clicks on the link and views another chapter", js: true do
      login

      visit big_book_path

      within "#chapter-view-panel" do
        expect(page).to_not have_content("WE, OF ALCOHOLICS ANONYMOUS")
      end

      within "#toc-main-panel" do
        expect(page).to have_content("1. BILL'S STORY")
        expect(page).to have_content("2. THERE IS A SOLUTION")
        click_on "2. THERE IS A SOLUTION"
      end

      within "#chapter-view-panel" do
        expect(page).to have_content("WE, OF ALCOHOLICS ANONYMOUS")
      end

    end
  end
end