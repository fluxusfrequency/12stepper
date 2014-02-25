require 'spec_helper'

describe User do
  context "#validations" do

    before do
      user = FactoryGirl.create(:user)
    end

    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :email }

  end

  context "#associations" do
    it { should have_many :entries }
    
    it { should have_many :friends }
    it { should have_many :inverse_friends }

    it { should have_many :friendships }
    it { should have_many :inverse_friendships }
  end

end
