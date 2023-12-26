class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :category
end
