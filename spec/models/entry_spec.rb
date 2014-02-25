require 'spec_helper'

describe Entry do
  context "#assocations" do
    before do
      entry = FactoryGirl.create(:entry)
    end

    it { should belong_to :user }
  end

  context "#becoming a status" do
    before do
      @user = FactoryGirl.create(:user)
      @entry = FactoryGirl.create(:entry, user_id: @user.id)
    end

    it "should be able to create a status version of itself" do
      expected = "I love being sober\n\nIt is the best feeling ever"
      expect(@entry.to_status).to eq(expected)
    end
  end
end