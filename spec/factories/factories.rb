FactoryGirl.define do

  factory :user do
    username "SecretSanta"
    email "santa@northpole.org"
    password_digest "password"
    password "password"
    password_confirmation "password"
    locale "en"
  end
end
