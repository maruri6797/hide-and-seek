FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    mbti { 'INTJ' }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end