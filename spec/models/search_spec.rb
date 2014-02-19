require 'spec_helper'

describe Search do
  before :each do
    chapter = FactoryGirl.create(:chapter)
    chapter2 = FactoryGirl.create(:chapter, body: "It was a cold winter in New England that year.")
  end

  it "should find the text in the search input and give back an array of search result objects" do
    expected_first = SearchResult.new(
      search_text: "New England", 
      chapter_number: 1, 
      chapter_title: "BILL'S STORY", 
      snippet: "...VER ran high in the <span class='search-result'>New England</span> town to which we new...")
    expected_last = "...as a cold winter in <span class='search-result'>New England</span> that year...."
    first = Search.in_big_book("New England").first
    last = Search.in_big_book("New England").last.snippet
    expect(first).to eq(expected_first)
    expect(last).to eq(expected_last)
  end
end
