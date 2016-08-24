# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do
  User.create!(
  username: Faker::Name.name,
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end
users = User.all

15.times do
  Topic.create!(
  name: Faker::Superhero.name,
  description: Faker::Lorem.sentences(1)
  )
end
topics = Topic.all

50.times do
  Question.create!(
  user: users.sample,
  topic: topics.sample,
  title: Faker::Book.title,
  body: Faker::Lorem.sentence(3)
  )
end
questions = Question.all

100.times do
  Answer.create!(
  user: users.sample,
  question: questions.sample,
  body: Faker::ChuckNorris.fact
  )
end

admin = User.create!(
  username: 'Admin User',
  email: 'mrsjpiki@gmail.com',
  password: 'helloworld',
  role: 'admin'
)
admin.confirm!

member = User.create!(
  username: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)
member.confirm!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Question.count} questions created"
puts "#{Answer.count} answers created"
