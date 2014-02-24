require 'spec_helper'

describe "Work a Step" do

  xit "pulls up the correct worksheet" do
    worksheet = FactoryGirl.create(:worksheet)
    login
    select("1",:from=> "work-a-step")
    click_on "Work a Step"
    expect(page).to have_content("Step 1")
    expect(page).to have_content(worksheet.title)
    expect(page).to have_content(worksheet.body)
  end

end
