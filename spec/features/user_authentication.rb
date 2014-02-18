require 'spec_helper'

describe "User Authentication" do

  it "a user can reach the sign up page" do
    visit '/'
    click_on "Sign Up"
    expect(page).to have_field("username")
    expect(page).to have_field("email")
    expect(page).to have_field("password")
    expect(page).to have_field("password_confirmation")
  end

end


