class VoteHistory < ApplicationRecord
  validates :user_id, :restaurant_id, :vote_split, presence: true
end
