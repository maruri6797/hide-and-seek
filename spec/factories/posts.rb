FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    text { Faker::Lorem.characters(number:30) }
    after(:create) do |post|
      create_list(:post_tag, 1, post: post, tag: create(:tag))
    end
  end
end