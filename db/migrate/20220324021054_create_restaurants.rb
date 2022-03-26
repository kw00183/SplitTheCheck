class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :will_split_count, :default => 0
      t.integer :wont_split_count, :default => 0

      t.timestamps
    end
  end
end
