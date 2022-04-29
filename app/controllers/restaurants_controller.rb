class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update vote comment favorite ]

  def inititialize
    self.clear_restaurants_list
    @search_made = false
    self.up
  end

  # GET /restaurants or /restaurants.json
  def index
    @search_made = true
    if params[:name].blank? == false
      list = Restaurant.where("name LIKE ?", "%" + params[:name] + "%")
      self.set_restaurants(list)
      @radio_checked_name = "checked"
      @display_div_name = "display: block;"
    elsif params[:address].blank? == false
      list = Restaurant.where("address LIKE ?", "%" + params[:address] + "%")
      self.set_restaurants(list)
      @radio_checked_address = "checked"
      @display_div_address = "display: block;"
    elsif params[:city].blank? == false
      list = Restaurant.where("city LIKE ?", "%" + params[:city] + "%")
      self.set_restaurants(list)
      @radio_checked_city = "checked"
      @display_div_city = "display: block;"
    elsif params[:state].blank? == false
      list = Restaurant.where("state LIKE ?", "%" + params[:state] + "%")
      self.set_restaurants(list)
      @radio_checked_state = "checked"
      @display_div_state = "display: block;"
    elsif params[:zip].blank? == false
      list = Restaurant.where("zip LIKE ?", "%" + params[:zip] + "%")
      self.set_restaurants(list)
      @radio_checked_zip = "checked"
      @display_div_zip = "display: block;"
    else
      self.clear_restaurants_list
    end
    self.get_restaurants
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
    @restaurant_comments = Comment.where(:restaurant_id => params[:id])
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # clear restaurants
  def clear_restaurants_list
    list = Restaurant.where(name: [nil, ""])
    self.set_restaurants(list)
    @radio_checked_name = "checked"
    @display_div_name = "display: block;"
    @search_made = false
  end

  # reset session
  def reset_session
    session.clear
  end

  # GET /restaurants
  def get_restaurants
    return @restaurants
  end

  # SET /restaurants
  def set_restaurants(list)
    @restaurants = list
  end

  # GET /restaurants/1/vote
  def vote
    @restaurant = Restaurant.find(params[:id])
  end

  # GET /restaurants/1/comment
  def comment
    @restaurant = Restaurant.find(params[:id])
  end

  # GET /restaurants/1/favorite
  def favorite
    @restaurant = Restaurant.find(params[:id])
  end

  # post comment to database
  def submit_comment
    @comment_string = params[:comment]
    @restaurant_id = params[:restaurant][:chosen_restaurant]
    @restaurant = Restaurant.find(@restaurant_id)
    @user_id = current_user.id

    @comment = Comment.create!(user_id: @user_id, restaurant_id: @restaurant_id, comment: @comment_string)

    respond_to do |format|
      format.html { redirect_to comment_path(@restaurant), notice: "Your comment was registered" }
    end
  end

  # post favorite to database
  def submit_favorite
    @favorite_param = params[:favorite].split[0]
    @restaurant_id = params[:favorite].split[1]
    @user_id = current_user.id

    @favorite_restaurant = Restaurant.find_by(id: @restaurant_id)

    if @favorite_param == "yes"
      @user_favorite = true
      @favorite = Favorite.create!(user_id: @user_id, restaurant_id: @restaurant_id, favorite_restaurant: @user_favorite)

      respond_to do |format|
        format.html { redirect_to favorite_path(@favorite_restaurant), notice: "Your choice was registered" }
      end
    elsif @favorite_param == "no"
      @user_favorite = false
      @favorite = Favorite.create!(user_id: @user_id, restaurant_id: @restaurant_id, favorite_restaurant: @user_favorite)

      respond_to do |format|
        format.html { redirect_to favorite_path(@favorite_restaurant), notice: "Your choice was registered" }
      end
    end
  end

  # post vote to database
  def submit_vote
    @vote = params[:vote].split[0]
    @restaurant_id = params[:vote].split[1]
    @user_id = current_user.id

    @user_vote = 0

    @vote_restaurant = Restaurant.find_by(id: @restaurant_id)

    if @vote == "will"
      @user_vote = 1
      @vote_history = VoteHistory.create!(user_id: @user_id, restaurant_id: @restaurant_id, vote_split: @user_vote)
      self.refresh_vote_counts(@restaurant_id)
      respond_to do |format|
        format.html { redirect_to vote_path(@vote_restaurant), notice: "Your vote of will was registered" }
      end
    elsif @vote == "wont"
      @vote_history = VoteHistory.create!(user_id: @user_id, restaurant_id: @restaurant_id, vote_split: @user_vote)
      self.refresh_vote_counts(@restaurant_id)
      respond_to do |format|
        format.html { redirect_to vote_path(@vote_restaurant), notice: "Your vote of won't was registered" }
      end
    end
  end

  def refresh_vote_counts(restaurant_id)
    self.update_counts_restaurant_will_split(restaurant_id)
    self.update_counts_restaurant_wont_split(restaurant_id)
  end

  def update_counts_restaurant_will_split(restaurant_id)
    will_count = VoteHistory.where(:restaurant_id => restaurant_id, :vote_split => 1).count
    @vote_restaurant.update(will_split_count: will_count)
  end

  def update_counts_restaurant_wont_split(restaurant_id)
    wont_count = VoteHistory.where(:restaurant_id => restaurant_id, :vote_split => 0).count
    @vote_restaurant.update(wont_split_count: wont_count)
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :will_split_count, :wont_split_count, :search, :id, :restaurant_id, :set_id)
    end
end
