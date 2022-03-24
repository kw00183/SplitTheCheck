class Restaurant < ApplicationRecord
  def self.search(search)
    if search && placeholder == 'name'
      @restaurants = Restaurant.find_by(name: search)
    elsif search && placeholder == 'address'
      @restaurants = Restaurant.find_by(address: search)
    elsif search && placeholder == 'city'
      @restaurants = Restaurant.find_by(city: search)
    elsif search && placeholder == 'state'
      @restaurants = Restaurant.find_by(state: search)
    elsif search && placeholder == 'zip'
      @restaurants = Restaurant.find_by(zip: search)
    else
      @restaurants = []
    end
  end
end
