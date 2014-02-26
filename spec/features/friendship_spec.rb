require 'spec_helper'

describe "User Friendships" do
  before :each do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user, email: "billy@example.com", username: "billy")
    @user3 = FactoryGirl.create(:user, email: "benny@example.com", username: "benny")
    @user4 = FactoryGirl.create(:user, email: "benny2@example.com", username: "benhorne44")
    FactoryGirl.create(:friendship, user_id: @user1.id, friend_id: @user2.id, status: "approved")
    FactoryGirl.create(:friendship, user_id: @user3.id, friend_id: @user1.id, status: "pending")
  end

  context "user can request a friend" do

    it "can find a user and request to be her friend", js: true do
      friendship_login
      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "Find Friends"
      end

      expect(current_path).to eq(new_friends_search_path(locale: :en))
      
      fill_in "Search for a Friend", with: "benhorne44"
      page.execute_script("$('#friend-search-form').submit()")

      within "#friend-search-results" do
        expect(page).to_not have_content("benny")
        expect(page).to_not have_content("billy")
        within "#search-result-benhorne44" do
          expect(page).to have_content("benhorne44")
          page.execute_script("$('#search-result-benhorne44 form').submit()")
        end
      end

      expect(page).to have_content("Your friend request was sent.")

      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "Find Friends"
      end

      expect(page).to have_content("Awaiting Confirmation")
      within "#awaiting-confirmation" do
        expect(page).to have_content("benhorne44")
      end
    end

    it "can't friend itself", js: true do
      friendship_login
      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "Find Friends"
      end

      fill_in "Search for a Friend", with: "SecretSanta"
      page.execute_script("$('#friend-search-form').submit()")

      within "#friend-search-results" do
        expect(page).to_not have_content("SecretSanta")
      end
    end

  end

  context "user views all of her friendships" do
    it "should see all of its friends on the friend index page", js: true do
      friendship_login

      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "View My Friends"
      end
      expect(page).to have_content(@user2.username)
    end
  end

  context "user views a friends profile" do
    it "sees the friends details", js: true do
      friendship_login

      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "View My Friends"
      end
      within "#friend-billy" do
        click_on "View Profile"
      end
      
      expect(page).to have_content("#{@user2.username}")
      expect(page).to have_content("#{@user2.days_sober.to_s} day sober!")
    end
  end

  context "user removes a friend" do
    it "can remove a friend listed in the index page", js: true do
      friendship_login

      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "View My Friends"
      end
      within "#friend-billy" do
        click_on "Remove"
      end
      expect(page).to have_content("REJECTED!")
    end
  end

  context "user accepts a friend request" do
    it "can see pending friend requests", js: true do
      friendship_login
      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "View My Friends"
      end

      within "#pending-friendships" do
        expect(page).to have_content "benny"
        within "#pending-benny" do
          click_on "Accept"
        end
      end

      expect(page).to have_content("You are now friends with benny.")
    end
  end

  context "user rejects a friend request" do
    it "can reject a friend request", js: true do
      friendship_login
      click_on "Welcome back, SecretSanta!"
      within ".dropdown-menu" do
        click_on "View My Friends"
      end

      within "#pending-friendships" do
        expect(page).to have_content "benny"
        within "#pending-benny" do
          click_on "Reject"
        end
      end

      expect(page).to have_content("REJECTED!")
    end
  end

  def friendship_login
    visit login_path(locale: :en)
    page.execute_script("$('#password').show()")
    within "#login-form" do
      fill_in "email", with: @user1.email
      fill_in "password", with: @user1.password
      click_on "Log in"
    end
  end
end