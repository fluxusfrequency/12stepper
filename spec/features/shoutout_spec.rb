require 'spec_helper'

describe "shouting out a user" do
  before :each do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user, email: "billy@example.com", username: "billy")
    @user3 = FactoryGirl.create(:user, email: "benny@example.com", username: "benny")
    @user4 = FactoryGirl.create(:user, email: "benny2@example.com", username: "benhorne44")
    FactoryGirl.create(:friendship, user_id: @user1.id, friend_id: @user2.id, status: "approved")
    FactoryGirl.create(:friendship, user_id: @user3.id, friend_id: @user1.id, status: "pending")
  end

  context "while posting a status" do

    it "should be able to shout out a friend when posting a status", js: true do
      shoutout_login
      within "#new-status-form" do
        fill_in "status[content]", with: "I like being sober. How about you, @billy?"
      end
      within ".found-shoutout" do
        expect(page).to have_content("billy")
      end
    end

    xit "should show up on the friend's feed", js: true do
      shoutout_login
      within "#new-status-form" do
        fill_in "status[content]", with: "I like being sober. How about you, @billy?"
      end
      click_on "Share"
      click_on "View My Friends"
      within "#friend-billy" do
        click_on "View Profile"
      end
      within "#recent-activity" do
        expect(page).to have_content "SecretSanta"
        expect(page).to have_content "I like being sober. How about you, @billy?"
      end
    end
  end






  def shoutout_login
    visit login_path(locale: :en)
    page.execute_script("$('#password').show()")
    within "#login-form" do
      fill_in "email", with: @user1.email
      fill_in "password", with: @user1.password
      click_on "Log in"
    end
  end
end