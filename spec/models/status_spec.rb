require 'spec_helper'

describe Status do
  context "#validations" do
    it {should validate_presence_of :content}
    it {should validate_presence_of :user_id}
  end

  context "#associations" do
    it {should belong_to :user}
  end
end