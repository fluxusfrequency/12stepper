require 'spec_helper'

describe "404 page" do
  it "should pop a 404 page when a logged in user enters a bad route" do
    login
    visit "/en/12nasf"
    expect(page).to have_content("404 - Something went wrong!")
  end

  it "should show the 404 page if the user is not authorized" do
    visit "/12nasf"
    expect(page).to have_content("404 - Something went wrong!")
  end
end