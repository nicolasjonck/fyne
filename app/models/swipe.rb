class Swipe < ApplicationRecord
  include PgSearch
  pg_search_scope :global_search,
    associated_against: {
      event: [ :name, :category, :subcategory, :venue_name, :city ]
    }

  belongs_to :user
  belongs_to :event

end
