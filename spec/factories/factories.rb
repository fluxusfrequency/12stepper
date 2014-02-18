FactoryGirl.define do

  factory :user do
    username "SecretSanta"
    email "santa@northpole.org"
    password_digest "password"
    language "en"
  end
end
