class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.boolean :favorite_restaurant, default: false

      t.timestamps
    end
  end
end
