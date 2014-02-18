require 'spec_helper'

describe BigBook::Chapter do
  context "#validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :chapter_number }
  end

end