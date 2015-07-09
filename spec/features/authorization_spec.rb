require 'spec_helper'

describe 'authorization' do
  context 'not logged in' do
    before do
      FactoryGirl.create(:user, username: "bobby", email: "bob@example.com")
      FactoryGirl.create(:chapter)
    end

    it "can't access pages it's unauthorized to see", js: true do
      visit root_path
      expect(page.current_path).to eq(login_path(locale: :en))

      visit entries_path
      expect(page.current_path).to eq(login_path(locale: :en))

      visit new_entry_path
      check_unauthorized

      # visit search_meetings_path
      # check_unauthorized

      visit big_book_path
      check_unauthorized

      visit page_path(id: "twelve-steps-en")
      check_unauthorized

      visit page_path(id: "twelve-traditions-en")
      check_unauthorized

      visit page_path(id: "serenity-prayer-en")
      check_unauthorized
    end

    it "can access pages it is authorized to see", js: true do
      login
      expect(page.current_path).to eq(root_path)

      visit new_entry_path
      check_authorized

      # visit search_meetings_path
      # check_authorized

      visit big_book_path
      check_authorized

      visit page_path(id: "twelve-steps-en")
      check_authorized

      visit page_path(id: "twelve-traditions-en")
      check_authorized

      visit page_path(id: "serenity-prayer-en")
      check_authorized
    end
  end

  def check_unauthorized
    expect(page.current_path).to eq(login_path(locale: :en))
    expect(page).to have_content "Please sign in first"
  end

  def check_authorized
    expect(page.current_path).to_not eq(login_path(locale: :en))
    expect(page).to_not have_content "Please sign in first"
  end
end
