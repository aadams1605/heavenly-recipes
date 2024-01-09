class Recipe < ApplicationRecord
  belongs_to :category
  has_many :favourites
  has_many :rating
end
