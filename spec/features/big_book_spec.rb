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
      chapter = FactoryGirl.create(:chapter)
      chapter2 = FactoryGirl.create(:chapter, 
        chapter_number: 2, 
        title: "THERE IS A SOLUTION", 
        body: "WE, OF ALCOHOLICS ANONYMOUS, know thousands of men and women...")
    end

    it "clicks on the link and views another chapter", js: true do
      login
      visit big_book_path(locale: :en)

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

  context "#search" do
    before :each do
      FactoryGirl.create(:chapter)
      FactoryGirl.create(:chapter, 
          chapter_number: 2, 
          title: "THERE IS A SOLUTION", 
          body: "WE, OF ALCOHOLICS ANONYMOUS, know thousands of men and women...")
      FactoryGirl.create(:chapter, 
          chapter_number: 3, 
          title: "MORE ABOUT ALCOHOLISM", 
          body: "MOST OF us have been unwilling to admit we were...")
    end

    it "executes a search and shows results panel", js: true do
      login
      visit big_book_path(locale: :en)

      expect(page).to have_selector("#toc-main-panel", visible: true)
      expect(page).to have_selector("#toc-search-tabs", visible: false)

      within "#toc-search-field-panel" do
        fill_in "toc-search-form[toc_search]", with: "ALCOHOL"
        click_on "Search"
      end

      expect(page).to have_selector("#toc-main-panel", visible: false)

      within "#toc-search-results-panel" do
        expect(page).to have_content("Search Results:")
        expect(page).to have_content("ALCOHOL")
        expect(page).to have_content("Chapter 2. THERE IS A SOLUTION")
        expect(page).to have_content("...ALCOHOLICS ANONYMOUS, know t...")
        expect(page).to have_content("Chapter 3. MORE ABOUT ALCOHOLISM")
        expect(page).to have_content("... to admit we were...ALCOHOL us have been unwilli...")
      end

      expect(page).to have_selector("#toc-search-tabs", visible: true)

      within "#toc-search-tabs" do
        click_on "Table of Contents"
      end

      expect(page).to have_selector("#toc-main-panel", visible: true)
      expect(page).to have_selector("#toc-search-results-panel", visible: false)

      within "#toc-search-tabs" do
        click_on "Search Results"
      end

      expect(page).to have_selector("#toc-main-panel", visible: false)
      expect(page).to have_selector("#toc-search-results-panel", visible: true)

      within "#toc-search-results-panel" do
        click_on "Chapter 2. THERE IS A SOLUTION"
      end
    end
  end
end