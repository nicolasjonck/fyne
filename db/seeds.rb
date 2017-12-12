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
puts 'Finished!'

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
    start_time: DateTime.new(2018,2,14,21),
    end_time: DateTime.new(2018,2,14,23),
    photo: "",
    street_address: "24 Rue du Commandant Guilbaud",
    city: "Paris",
    zip_code: "75016",
    state: "Paris",
    country: "France",
    user_id: User.first.id,
  },
  {
    name: "DJ Snake @AccorHotel Arena",
    category: "Music",
    subcategory: "Electro",
    start_time: DateTime.new(2018,2,24,21),
    end_time: DateTime.new(2018,2,24,22),
    photo: "",
    street_address: "8 Boulevard de Bercy",
    city: "Paris",
    zip_code: "75012",
    state: "Paris",
    country: "France",
    user_id: User.last.id,
  }
]
Event.create!(events_attributes)
puts 'Finished!'

