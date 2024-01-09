class Category < ApplicationRecord
  has_many :favourites
  has_many :recipe
end
