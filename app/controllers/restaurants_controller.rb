class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  def inititialize
    list = Restaurant.where(name: [nil, ""])
    self.set_restaurants(list)
  end

  # GET /restaurants or /restaurants.json
  def index
    if params[:name].blank? == false
      list = Restaurant.where("name LIKE ?", "%" + params[:name] + "%")
      self.set_restaurants(list)
    elsif params[:address].blank? == false
      list = Restaurant.where("address LIKE ?", "%" + params[:address] + "%")
      self.set_restaurants(list)
    elsif params[:city].blank? == false
      list = Restaurant.where("city LIKE ?", "%" + params[:city] + "%")
      self.set_restaurants(list)
    elsif params[:state].blank? == false
      list = Restaurant.where("state LIKE ?", "%" + params[:state] + "%")
      self.set_restaurants(list)
    elsif params[:zip].blank? == false
      list = Restaurant.where("zip LIKE ?", "%" + params[:zip] + "%")
      self.set_restaurants(list)
    else
      list = Restaurant.where(name: [nil, ""])
      self.set_restaurants(list)
    end
    self.get_restaurants
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
      params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :will_split_count, :wont_split_count, :search)
    end
end
