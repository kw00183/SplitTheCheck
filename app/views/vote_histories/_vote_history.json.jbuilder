json.extract! vote_history, :id, :user_id, :restaurant_id, :vote_split, :created_at, :updated_at
json.url vote_history_url(vote_history, format: :json)
