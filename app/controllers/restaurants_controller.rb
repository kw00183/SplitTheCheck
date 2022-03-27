class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update vote ]

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

  def clear_restaurants_list
    list = Restaurant.where(name: [nil, ""])
    self.set_restaurants(list)
    @radio_checked_name = "checked"
    @display_div_name = "display: block;"
    @search_made = false
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  def reset_session
    session.clear
  end

  def get_restaurants
    return @restaurants
  end

  def set_restaurants(list)
    @restaurants = list
  end

  def vote
    params[:id] = @restaurant.id
  end

  def submit_vote
    param_id = params[:id]
    puts params[:id].to_s + "sinsinsinsinsinsinsinsinsinsinsins"

    @restaurant = Restaurant.find_by(params[:id])

    puts params[:id].to_s + "lessssssss"

    will_count = @restaurant.will_split_count + 1
    wont_count = @restaurant.wont_split_count + 1

    if params[:vote] == "will"
      Restaurant.find_by(params[:id]).tap{|restaurant| restaurant.will_split_count = will_count }.save
      respond_to do |format|
        format.html { redirect_to vote_path(@restaurant), notice: "Your vote of will was registered" }
      end
    elsif params[:vote] == "wont"
      Restaurant.find_by(params[:id]).tap{|restaurant| restaurant.wont_split_count = wont_count }.save
      respond_to do |format|
        format.html { redirect_to vote_path(@restaurant), notice: "Your vote of won't was registered" }
      end
    end

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
