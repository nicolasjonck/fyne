# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeding the users

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
    category: "Sports",
    subcategory: "Football",
    start_time: DateTime.new(2018,2,24,20,45,0),
    end_time: DateTime.new(2018,2,24,22,45,0),
    photo: "",
    street_address: "24 Rue du Commandant Guilbaud",
    city: Faker::Address.city,
    zip_code: "75016",
    state: "Paris",
    country: "France",
    user_id: User.first.id,
  },
  {
    name: "DJ Snake @AccorHotel Arena",
    category: "Music",
    subcategory: "Electro",
    start_time: DateTime.new(2018,2,24,21,4,9),
    end_time: DateTime.new(2018,2,24,22,9,0),
    photo: "",
    street_address: "8 Boulevard de Bercy",
    city: "Paris",
    zip_code: "75012",
    state: "Paris",
    country: "France",
    user_id: User.last.id,
  },
  {
    name: "Vianney @Ancienne Belgique",
    category: "Music",
    subcategory: "Pop",
    start_time: DateTime.new(2017,2,24,21,4,9),
    end_time: DateTime.new(2018,2,24,22,9,0),
    photo: "",
    street_address: "12 Grand Place",
    city: "Brussels",
    zip_code: "1000",
    state: "Brussels",
    country: "Belgium",
    user_id: User.last.id,
  },
  {
    name: "Belgium - Georgia @King Baudouin Stadium",
    category: "Sports",
    subcategory: "Rugby",
    start_time: DateTime.new(2018,2,24,20,0,0),
    end_time: DateTime.new(2018,2,24,22,0,0),
    photo: "",
    street_address: "Avenue de Marathon 135",
    city: "Brussels",
    zip_code: "1020",
    state: "Brussels",
    country: "Belgium",
    user_id: User.last.id,
  },
    {
    name: "Brunch in the Park",
    category: "Music",
    subcategory: "Electro",
    start_time: DateTime.new(2018,2,24,12,45,0),
    end_time: DateTime.new(2018,2,24,22,45,0),
    photo: "",
    street_address: "Ctra. de Montjuïc 40",
    city: "Barcelona",
    zip_code: "08038",
    state: "Barcelona",
    country: "Spain",
    user_id: User.first.id,
  },
  {
    name: "El Molino On @El Molino Theatre",
    category: "Art & Culture",
    subcategory: "Theatre",
    start_time: DateTime.new(2018,2,24,19,0,0),
    end_time: DateTime.new(2018,2,24,22,0,0),
    photo: "",
    street_address: "Carrer de Vila i Vilà 99",
    city: "Barcelona",
    zip_code: "08004",
    state: "Barcelona",
    country: "Spain",
    user_id: User.last.id,
  },
  {
    name: "Parc de la Ciutadella",
    category: "Crafting",
    subcategory: "Gardening",
    start_time: DateTime.new(2017,2,24,21,4,9),
    end_time: DateTime.new(2018,2,24,22,9,0),
    photo: "",
    street_address: "21 Passeig de Picasso",
    city: "Barcelona",
    zip_code: "08003",
    state: "Barcelona",
    country: "Spain",
    user_id: User.last.id,
  },
  {
    name: "Alimentaria",
    category: "Tasting & Restauration",
    subcategory: "Food tasting",
    start_time: DateTime.new(2018,4,16,12,0,0),
    end_time: DateTime.new(2018,4,18,22,0,0),
    photo: "",
    street_address: "Gran Via",
    city: "Barcelona",
    zip_code: "08028",
    state: "Barcelona",
    country: "Spain",
    user_id: User.last.id,
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
