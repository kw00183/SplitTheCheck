class Favorite < ApplicationRecord
  validates :favorite_restaurant, presence: true
end
