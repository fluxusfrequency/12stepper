require 'spec_helper'

describe "Work a Step" do

  it "pulls up the correct worksheet" do
    login
    select("1",:from=> "work-a-step")
    click_on "Work a Step"
    save_and_open_page
    expect(page).to have_content("Step 1")
  end

end
