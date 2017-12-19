# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeding the users

require 'faker'

puts 'Cleaning user database...'
User.destroy_all

puts 'Creating users...'
users_attributes = [
  {
    email:         "pierrealexis@gmail.com",
    password: "pierrealexis",
    first_name: "Pierre-Alexis",
    last_name:  "Bayen",
    city:        "Paris",
    photo: "",
  },
  {
    email:         "nicolas@gmail.com",
    password: "nicolas",
    first_name:      "Nicolas",
    last_name:  "Jonckheere",
    city:        "Brussels",
    photo: "",
  },
  {
    email:         "madi@gmail.com",
    password: "madiha",
    first_name:      "Madiha",
    last_name:  "Latafi",
    city:        "Paris",
    photo: "",
  }
]
User.create!(users_attributes)
puts 'Finished with users!'

# Seeding the events

require 'date'

puts 'Cleaning event database'
Event.destroy_all

puts 'Creating events...'

events_attributes = [
  {
    name: "PSG vs. Real Madrid",
    category: "sports",
    subcategory: "sports_football",
    start_time: DateTime.new(2017,12,18,20,45,0),
    end_time: DateTime.new(2017,12,18,22,45,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "24 Rue du Commandant Guilbaud",
    city: Faker::Address.city,
    zip_code: "75016",
    state: "Paris",
    country: "France",
    user_id: User.where(email: "pierrealexis@gmail.com"),
  },
  {
    name: "DJ Snake",
    category: "music",
    subcategory: "music_electronic",
    start_time: DateTime.new(2017,12,24,21,4,9),
    end_time: DateTime.new(2017,12,24,22,9,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "8 Boulevard de Bercy",
    city: "Paris",
    zip_code: "75012",
    state: "Paris",
    country: "France",
    user_id: User.where(email: "nicolas@gmail.com"),
  },
  {
    name: "Vianney @Ancienne Belgique",
    category: "music",
    subcategory: "music_folk",
    start_time: DateTime.new(2017,12,19,21,4,9),
    end_time: DateTime.new(2018,12,19,22,9,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "12 Grand Place",
    city: "Brussels",
    zip_code: "1000",
    state: "Brussels",
    country: "Belgium",
    user_id: User.where(email: "madi@gmail.com"),
  },
  {
    name: "Belgium - Georgia @King Baudouin Stadium",
    category: "sports",
    subcategory: "sports_rugby",
    start_time: DateTime.new(2017,12,18,20,0,0),
    end_time: DateTime.new(2017,12,18,22,0,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "Avenue de Marathon 135",
    city: "Brussels",
    zip_code: "1020",
    state: "Brussels",
    country: "Belgium",
    user_id: User.where(email: "madi@gmail.com"),
  },
  {
    name: "El Molino On @El Molino Theatre",
    category: "comedy",
    subcategory: "comedy",
    start_time: DateTime.new(2017,12,24,19,0,0),
    end_time: DateTime.new(2017,12,24,22,0,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "Carrer de Vila i Vilà 99",
    city: "Barcelona",
    zip_code: "08004",
    state: "Barcelona",
    country: "Spain",
    user_id: User.where(email: "pierrealexis@gmail.com"),
  },
  {
    name: "Alimentaria",
    category: "food",
    subcategory: "food_tastings",
    start_time: DateTime.new(2017,12,23,12,0,0),
    end_time: DateTime.new(2017,12,23,22,0,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "Gran Via",
    city: "Barcelona",
    zip_code: "08028",
    state: "Barcelona",
    country: "Spain",
    user_id: User.where(email: "pierrealexis@gmail.com"),
  },
]

# Event.create!(events_attributes)
  events_attributes.each do |event|
    Event.create!(event)
    puts "#{event[:name]} has been created!"
  end

puts "Events created!"

# Seeding the swipes

puts 'Cleaning swipe database'
Swipe.destroy_all

puts 'Creating swipes...'

swipes_attributes = []

User.all.each do |user|
  Event.all.each do |event|
    swipes_attributes << {
    user_id: user.id,
    event_id: event.id,
    interested: [true, false].sample,
  }
  end
end

Swipe.create!(swipes_attributes)
puts 'Finished with swipes!'

# Creating events that have not been swiped by the user

puts 'Creating events not swiped yet'

events_not_swiped_attributes = [
  { name: "Lyon vs. Barcelona",
    category: "sports",
    subcategory: "sports_football",
    start_time: DateTime.new(2017,12,23,20,45,0),
    end_time: DateTime.new(2017,12,23,22,45,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "28 Rue du Commandant Guilbaud",
    city: Faker::Address.city,
    zip_code: "75016",
    state: "Saint Germain",
    country: "France",
    user_id: User.first.id,
  },
  { name: "Marseille vs. PSG",
    category: "sports",
    subcategory: "sports_football",
    start_time: DateTime.new(2018,2,25,20,45,0),
    end_time: DateTime.new(2018,2,25,22,45,0),
    photo: "https://picsum.photos/200/300/?random",
    street_address: "28 Rue du Commandant Guilbaud",
    city: Faker::Address.city,
    zip_code: "75016",
    state: "Saint Germain",
    country: "France",
    user_id: User.last.id,
  },
]

# 50.times do
#   events_not_swiped_attributes << {
#     name: "#{Faker::Name.name}'s concert",
#     category: "Music",
#     subcategory: "Alternative",
#     start_time: DateTime.new(2018,2,25,20,45,0),
#     end_time: DateTime.new(2018,2,25,22,45,0),
#     photo: "https://picsum.photos/200/300/?random",
#     street_address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     zip_code: Faker::Address.zip_code,
#     state: Faker::Address.state,
#     country: Faker::Address.country,
#     user_id: User.first.id,
#   }
#   puts "#{events_not_swiped_attributes.last[:name]} added to the array"
# end

Event.create!(events_not_swiped_attributes)
puts 'Finished with events not swiped'
