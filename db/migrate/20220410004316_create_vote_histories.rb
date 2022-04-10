class CreateVoteHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :vote_histories do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.boolean :vote_split, default: false

      t.timestamps
    end
  end
end
