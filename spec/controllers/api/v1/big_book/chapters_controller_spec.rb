require 'spec_helper'
require 'json_spec'

describe Api::V1::BigBook::ChaptersController do
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
    expect(Api::V1::BigBook::ChaptersController).to be
  end

  it { should respond_to :index }
  it { should respond_to :show }

  describe "GET /api/v1/big_book/chapters" do
    it "returns a list of stores" do
      get :index, format: :json
      expect(JSON.parse(response.body).length).to be(3)
      expect(response.body).to have_json_path('0/body')
      expect(response.body).to be_json_eql(%|"BILL'S STORY"|).at_path('0/title')

      expect(response.body).to have_json_path('1/chapter_number')
      expect(response.body).to be_json_eql(%|"THERE IS A SOLUTION"|).at_path('1/title')
    end
  end

  describe 'GET api/v1/big_book/chapters/:id' do
    it 'returns the attributes for a store' do
      get :show, id: @chapter3.id, format: :json
      expect(response.body).to have_json_path('title')
      expect(response.body).to have_json_path('body')
      expect(response.body).to be_json_eql(%|"MORE ABOUT ALCOHOLISM"|).at_path("title")
      expect(response.body).to be_json_eql(%|"MOST OF us have been unwilling to admit we were..."|).at_path("body")
    end
  end

end