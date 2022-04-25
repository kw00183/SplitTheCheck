class UsersController < ApplicationController
  include ActionController::Helpers
  include UsersHelper

  before_action :validate_url_hack

  def validate_url_hack
    # Check the params hash to see if the passed :id matches the current user's id
    # (note the .to_i on params[:id], as you are comparing against a Fixnum)
    unless params[:id].to_i == current_user.id
      # This line redirects the user to the previous action
      redirect_to root_path
    end
  end

  # GET summary
  def summary
    @user = current_user
    self.get_vote_activity
    self.get_comment_activity
    self.get_favorite_activity
  end

  def get_comment_activity
    sql = "SELECT comments.user_id, comments.restaurant_id, comments.comment, restaurants.name, comments.created_at FROM comments
      JOIN restaurants ON comments.restaurant_id = restaurants.id
      WHERE comments.user_id = " + current_user.id.to_s + " ORDER BY comments.comment DESC"

    @comment_activity = Comment.find_by_sql(sql)
  end

  def get_vote_activity
    sql = "SELECT vote_histories.user_id, vote_histories.restaurant_id, vote_histories.vote_split, restaurants.name, vote_histories.created_at FROM vote_histories
      JOIN restaurants ON vote_histories.restaurant_id = restaurants.id
      WHERE vote_histories.user_id = " + current_user.id.to_s + " ORDER BY vote_histories.created_at DESC"

    @vote_activity = VoteHistory.find_by_sql(sql)
  end

  def get_favorite_activity
    sql = "SELECT final.user_id, final.restaurant_id, final.favorite_restaurant, final.name, final.created_at
      FROM (SELECT favorites.user_id, favorites.restaurant_id, MAX(favorites.created_at) AS created_at
      , restaurants.name, favorites.favorite_restaurant FROM favorites
      JOIN restaurants ON favorites.restaurant_id = restaurants.id
      WHERE favorites.user_id = " + current_user.id.to_s + " GROUP BY favorites.user_id
      , favorites.restaurant_id ORDER BY favorites.created_at DESC) final
      WHERE final.favorite_restaurant = 1"

    @favorite_activity = Favorite.find_by_sql(sql)
  end
end
