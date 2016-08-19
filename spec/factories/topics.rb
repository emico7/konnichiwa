FactoryGirl.define do
  factory :topic do
    name Faker::Superhero.name
    public true
    description Faker::Lorem.sentences(1)
  end
end
