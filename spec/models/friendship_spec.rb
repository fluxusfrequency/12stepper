require 'spec_helper'

describe Friendship do
  context "#validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :friend_id }
    it { should validate_presence_of :status }
    xit { should ensure_inclusion_of(:status).in_array(%w(pending approved)) }
  end

  context "#associations" do
    it { should belong_to :user }
    it { should belong_to :friend }
  end
end