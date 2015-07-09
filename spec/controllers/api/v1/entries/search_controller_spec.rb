require 'spec_helper'
require 'json_spec'

describe Api::V1::Entries::SearchController, type: :controller do
  before :each do
    user = FactoryGirl.create(:user)
    subject.stub(:current_user).and_return(user)

    FactoryGirl.create(:entry, user_id: user.id, title: "Tough one",
      body: "Some days it's hard to stick with it.", step: 4)
    FactoryGirl.create(:entry, user_id: user.id, title: "Good one",
      body: "It's hard sometimes, but today it was easy.")
  end

  it "should exist" do
    expect(Api::V1::Entries::SearchController).to be
  end

  it { should respond_to :show }

  describe "GET /api/v1/entries/search/:query" do
    it "returns only matching results" do
      get :show, query: "stick with it", format: :json
      expect(JSON.parse(response.body).length).to be(1)
      expect(response.body).to have_json_path('0/title')
      expect(response.body).to be_json_eql(%|"Tough one"|).at_path('0/title')
      expect(response.body).to be_json_eql(%|"Some days it's hard to stick with it."|).at_path('0/body')
      expect(response.body).to be_json_eql(%|4|).at_path('0/step')
    end

    it "returns an array of search results when they all match" do
      get :show, query: "it's hard", format: :json
      expect(JSON.parse(response.body).length).to be(2)
      expect(response.body).to have_json_path('0/title')
      expect(response.body).to have_json_path('1/title')
      expect(response.body).to include("Tough one")
      expect(response.body).to include("Good one")
      expect(response.body).to include("Some days it's hard to stick with it.")
      expect(response.body).to include("It's hard sometimes, but today it was easy.")
      expect(response.body).to include("4")
    end
  end

end
