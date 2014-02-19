require 'spec_helper'

describe Search do
  before :each do
    chapter = FactoryGirl.create(:chapter)
  end

  it "should find the text in the search input and give back a search result object" do
    expected = SearchResult.new(
      search_text: "New England", 
      chapter_number: 1, 
      chapter_title: "BILL'S STORY", 
      snippet: "WAR FEVER ran high in the New England town to which we new, young")
    actual = Search.in_big_book("New England")
    expect(actual).to eq(expected)
  end
end