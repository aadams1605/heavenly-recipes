class Recipe < ApplicationRecord
  belongs_to :category
  has_many :favourites
  has_many :ratings

  include PgSearch::Model
  pg_search_scope :search_by_recipe,
                  against: [ :title ],
                  associated_against: {
                  category:[ :title ]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
