json.extract! favorite, :id, :user_id, :restaurant_id, :favorite_restaurant, :created_at, :updated_at
json.url favorite_url(favorite, format: :json)
