# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  city = City.create!(name: Faker::Address.city, 
                      zip_code: Faker::Address.zip_code)
end

10.times do
  city = City.find_by(id: rand(1..City.all.length))

  user = User.create!(first_name: Faker::Name.first_name, 
                      last_name: Faker::Name.last_name,
                      description: Faker::Lorem.sentence,
                      email: Faker::Internet.email,
                      age: rand(19..50),
                      city: city,
                      password: "tototo",
                      password_confirmation: "tototo")
end

15.times do
  user = User.find_by(id: rand(1..User.all.length))

  gossip = Gossip.create!(title: Faker::Lorem.paragraph_by_chars(number: 10, supplemental: false), 
                          content: Faker::TvShows::Simpsons.quote,
                          user: user)
end

40.times do
  user = User.find_by(id: rand(1..User.all.length))
  gossip = Gossip.find_by(id: rand(1..Gossip.all.length))

  comment = Comment.create!(content: Faker::Movies::HarryPotter.quote,
                            user: user,
                            gossip: gossip)
end