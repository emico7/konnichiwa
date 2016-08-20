FactoryGirl.define do
  factory :topic do
    name Faker::Superhero.name
    public true
    description Faker::Lorem.sentence(3)
  end
end
