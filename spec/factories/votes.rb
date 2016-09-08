FactoryGirl.define do
  factory :vote do
    value 1
    user
    question
  end
end
