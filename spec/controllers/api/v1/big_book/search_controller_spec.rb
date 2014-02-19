require 'spec_helper'
require 'json_spec'

describe Api::V1::BigBook::SearchController do
  before :each do
    @chapter1 = FactoryGirl.create(:chapter)
    @chapter2 = FactoryGirl.create(:chapter, 
        chapter_number: 2, 
        title: "THERE IS A SOLUTION", 
        body: "WE, OF ALCOHOLICS ANONYMOUS, know thousands of men and women...")
    @chapter3 = FactoryGirl.create(:chapter, 
        chapter_number: 3, 
        title: "MORE ABOUT ALCOHOLISM", 
        body: "MOST OF us have been unwilling to admit we were...")
  end

  it "should exist" do
    expect(Api::V1::BigBook::SearchController).to be
  end

  it { should respond_to :show }

  describe "GET /api/v1/big_book/search/:query" do
    it "returns an array of search results" do
      get :show, query: "ALCOHOL", format: :json
      expect(JSON.parse(response.body).length).to be(2)
      expect(response.body).to have_json_path('0/snippet')
      expect(response.body).to be_json_eql(%|"THERE IS A SOLUTION"|).at_path('0/chapter_title')

      expect(response.body).to have_json_path('1/chapter_number')
      expect(response.body).to be_json_eql(%|"... to admit we were...\u003Cspan class='search-result'\u003EALCOHOL\u003C/span\u003E us have been unwilli..."|).at_path('1/snippet')
    end
  end

end