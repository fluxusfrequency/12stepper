require 'spec_helper'

describe Entry do
  context "#assocations" do
    before do
      entry = FactoryGirl.create(:entry)
    end

    it { should belong_to :user }
  end
end