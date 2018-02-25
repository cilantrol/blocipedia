FactoryBot.define do
  factory :user do
    email "asdfasdf@asdf.com"
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    role :standard
  end
end