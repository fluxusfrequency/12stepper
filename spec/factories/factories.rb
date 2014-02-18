FactoryGirl.define do

  factory :user do
    username "SecretSanta"
    email "santa@northpole.org"
    password_digest "password"
    password "password"
    password_confirmation "password"
    locale "en"
  end

  factory :chapter, :class => BigBook::Chapter do
    title "BILL'S STORY"
    body "WAR FEVER ran high in the New England town to which we new, young officers from Plattsburg were assigned..."
    chapter_number 1
  end
end
