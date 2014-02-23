FactoryGirl.define do

  factory :user do
    username "SecretSanta"
    email "santa@northpole.org"
    password_digest "password"
    password "password"
    password_confirmation "password"
    locale "en"
    last_drink Time.now
  end

  factory :chapter, :class => BigBook::Chapter do
    title "BILL'S STORY"
    body "WAR FEVER ran high in the New England town to which we new, young officers from Plattsburg were assigned..."
    chapter_number 1
  end

  factory :entry do
    title "I love being sober"
    body "It is the best feeling ever"
    user_id 1
    step 3
  end

  factory :worksheet do
    title "Section 1"
    body "Section questions"
    step 1
    locale "en"
  end
end
