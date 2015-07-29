require 'faker'

# Create Users
5.times do
 user = User.new(
   name:     Faker::Name.name,
   email:    Faker::Internet.email,
   password: Faker::Lorem.characters(10)
 )
 user.skip_confirmation!
 user.save!
end

user = User.new(
   name:     'Selene',
   email:    'hakobyan.sn@gmail.com',
   password: 'password'
 )
 user.skip_confirmation!
 user.save!

users = User.all

15.times do
  Topic.create!(
    title:         Faker::Lorem.sentence
    )
end

topics = Topic.all

60.times do
  Bookmark.create!(
    url:         Faker::Internet.url(Faker::Lorem.characters(10), '.com'),
    topic:       topics.sample,
    user:        users.sample
    )
end

topics = Topic.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
