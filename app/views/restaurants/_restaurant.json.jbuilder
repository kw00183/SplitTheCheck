json.extract! restaurant, :id, :name, :address, :city, :state, :zip, :will_split_count, :wont_split_count, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
