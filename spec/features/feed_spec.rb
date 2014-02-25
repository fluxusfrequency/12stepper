require 'spec_helper'

describe "feed" do
  context "index" do
    before do
      @user = FactoryGirl.create(:user)
      @status1 = FactoryGirl.create(:status, :user_id => @user.id)
      @status2 = FactoryGirl.create(:status, :content => "My second status update", :user_id => @user.id)
    end

    it "should see all of its own statuses in the feed", js: true do
      feed_login
      within "#feed-activity" do
        expect(page).to have_content("My first status update")
        expect(page).to have_content("My second status update")
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
      within "#new-status" do
        fill_in "status[content]", with: "My first status update"
        click_on "Post"
      end
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
        fill_in "status[content]", with: "This is my updated status."
        click_on "Save"
        expect(page).to_not have_content("This is my first status.")
        expect(page).to have_content("This is my updated status.")
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