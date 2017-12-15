class Event < ApplicationRecord
  belongs_to :user
  has_many :swipe, dependent: :destroy
  validates :name, presence: true
  validates :category, presence: true, inclusion: { in: ["Art & Culture", "Music", "Films & Series", "Sports", "Games", "Wellness & Health", "Spirituality", "Non-profit", "Tasting & Restauration", "Crafting", "Party", "Business", "Politics", "Other"] }
  validates :subcategory, presence: true, inclusion: { in: ["Theatre", "Literature", "Alternative", "Blues", "Classical", "Dance", "Electro", "Hip-hop/Rap", "Jazz", "Metal", "For children", "World music", "Pop", "Raggae", "Rock", "Other genre", "Action", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "History", "Horror", "Musical", "Romance", "Sport", "War", "Western", "Football", "Rugby", "Tennis", "Formula 1", "Auto/moto", "Basket", "Handball", "Golf", "Cycle", "Winter sports", "Athletism", "Swimming", "Volley-ball", "Other sports", "Games", "Dancing", "Fitness", "Health", "Spirituality", "Non-profit", "Food tasting", "Drink tasting", "Crafting (General)", "Gardening", "Home", "Party", "Networking", "Shopping", "Conference", "Politics", "Other"] }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :country, presence: true

  has_attachment :photouploaded
end
