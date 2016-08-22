FactoryGirl.define do
  factory :answer do
    body Faker::ChuckNorris.fact
    question
    user
  end
end
