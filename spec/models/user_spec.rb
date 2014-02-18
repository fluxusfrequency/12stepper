require 'spec_helper'

describe User do
  it "requires a username" do
    user1 = FactoryGirl.build(:user)
    user2 = FactoryGirl.build(:user, username: '')
    expect(user1).to be_valid
    expect(user2).to_not be_valid
  end

  it "requires an email" do
    user1 = FactoryGirl.build(:user)
    user2 = FactoryGirl.build(:user, email: '')
    expect(user1).to be_valid
    expect(user2).to_not be_valid
  end

  it "requires a unique email" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user)
    expect(user1).to be_valid
    expect(user2).to_not be_valid
  end


end
