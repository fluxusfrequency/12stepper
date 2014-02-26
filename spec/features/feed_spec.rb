require 'spec_helper'

describe "feed" do
  context "index" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user, username: "bennybeans", email: "ben@example.com")
      @user3 = FactoryGirl.create(:user, username: "billybeans", email: "billy@example.com")
      @status1 = FactoryGirl.create(:status, :user_id => @user.id)
      @status2 = FactoryGirl.create(:status, :content => "My second status update", :user_id => @user.id)
      @status3 = FactoryGirl.create(:status, :content => "Benny's status update", :user_id => @user2.id)
      @status4 = FactoryGirl.create(:status, :content => "Billy's status update", :user_id => @user3.id)
      FactoryGirl.create(:friendship, user_id: @user.id, friend_id: @user2.id, status: "approved")
    end

    it "should see all of its own statuses in the feed", js: true do
      feed_login
      within "#feed-activity" do
        expect(page).to have_content("My first status update")
        expect(page).to have_content("My second status update")
      end
    end

    it "should see only its friends statuses in the feed", js: true do
      feed_login
      
      within "#feed-activity" do
        expect(page).to have_content("My first status update")
        expect(page).to have_content("My second status update")
        expect(page).to have_content("Benny's status update")
        expect(page).to_not have_content("Billy's status update")
      end
    end

  end

  context "new/create" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "should see a new status in the feed after creating one", js: true do
      feed_login
      within "#feed-activity" do
        expect(page).to_not have_content("My first status update")
      end
      within "#new-status-form" do
        fill_in "status[content]", with: "My first status update"
      end
      click_on "Share"
      expect(page).to have_content("Your status was posted")
      within "#feed-activity" do
        expect(page).to have_content("My first status update")
      end
    end
  end

  context "edit" do
    before do
      @user = FactoryGirl.create(:user)
      @status = FactoryGirl.create(:status, user_id: @user.id)
    end

    it "can edit a status it posted", js: true do
      feed_login
      within "#status-#{@status.id}" do
        click_on "Edit"
      end
      within "#edit-status" do
        fill_in "status[content]", with: "This is my updated status."
        find("#update-submit").trigger('click')
      end
      expect(page).to_not have_content("This is my first status.")
      expect(page).to have_content("This is my updated status.")
    end
  end

  context "delete" do
    before do
      @user = FactoryGirl.create(:user)
      @status = FactoryGirl.create(:status, user_id: @user.id)
    end

    it "can remove a status it posted", js: true do
      feed_login
      within "#status-#{@status.id}" do
        click_on "Delete"
      end
      expect(page).to_not have_content("This is my first status.")
    end
  end

  context "posting a journal entry" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user, username: "bennybeans", email: "ben@example.com")
      @status = FactoryGirl.create(:status, :user_id => @user.id)
      @entry = FactoryGirl.create(:entry, :user_id => @user.id)
      FactoryGirl.create(:friendship, user_id: @user.id, friend_id: @user2.id, status: "approved")
    end

    it "can post a journal entry as a status", js: true do
      feed_login

      within "#feed-activity" do
        expect(page).to have_content("My first status update")
      end

      click_on "Journal"
      click_on "I love being sober"
      click_on "Save and Share"
      save_and_open_page
      expect(page).to have_content("Shared your entry.")
      within "#feed-activity" do
        expect(page).to have_content("I love being sober")
      end
      
    end
  end

  def feed_login
    visit login_path(locale: :en)
    page.execute_script("$('#password').show()")
    within "#login-form" do
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_on "Log in"
    end
  end
end