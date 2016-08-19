FactoryGirl.define do
  factory :question do
    title Faker::Book.title
    body Faker::Lorem.sentence(3)
    topic
  end
end
