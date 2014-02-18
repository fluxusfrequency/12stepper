require 'spec_helper'

describe "Big Book" do
  context "#index" do

    it "sees the table of contents and first chapter" do
      login
      FactoryGirl.create(:chapter)
      visit big_book_chapters_path
      expect(page).to have_content("Table of Contents")
      expect(page).to have_content("WAR FEVER ran high in the New England town to which we new, young officers from Plattsburg were assigned")
    end

  end
end