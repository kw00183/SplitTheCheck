require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:fix_1)
  end

  test "should get by name" do
    get restaurants_url

    get "/search?name=" + "Hotel_3"

    assert_response :success
    assert_select "td#restaurant_name", text: "Hotel_3"
  end

  test "should get by address" do
    get restaurants_url

    get "/search?address=" + "Address_3"

    assert_response :success
    assert_select "td#restaurant_address", text: "Address_3"
  end

  test "should get by city" do
    get restaurants_url

    get "/search?city=" + "City_3"

    assert_response :success
    assert_select "td#restaurant_city", text: "City_3"
  end

  test "should get by state" do
    get restaurants_url

    get "/search?state=" + "State_3"

    assert_response :success
    assert_select "td#restaurant_state", text: "State_3"
  end

  test "should get by zip" do
    get restaurants_url

    get "/search?zip=" + "Zip_3"

    assert_response :success
    assert_select "td#restaurant_zip", text: "Zip_3"
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, will_split_count: @restaurant.will_split_count, wont_split_count: @restaurant.wont_split_count, zip: @restaurant.zip } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, state: @restaurant.state, will_split_count: @restaurant.will_split_count, wont_split_count: @restaurant.wont_split_count, zip: @restaurant.zip } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy restaurant" do
#    assert_difference('Restaurant.count', -1) do
#      delete restaurant_url(@restaurant)
#    end

#    assert_redirected_to restaurants_url
  end
end
