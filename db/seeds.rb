# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

15.times do
  Topic.create!(
  name: Faker::Superhero.name,
  description: Faker::Lorem.sentences(1)
  )
end
topics = Topic.all

50.times do
  Question.create!(
  topic: topics.sample,
  title: Faker::Book.title,
  body: Faker::Lorem.sentence(3)
  )
end
questions = Question.all

100.times do
  Answer.create!(
  question: questions.sample,
  body: Faker::ChuckNorris.fact
  )
end

puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Question.count} questions created"
puts "#{Answer.count} answers created"
