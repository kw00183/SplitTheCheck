require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @restaurant = restaurants(:fix_1)

#    get '/users/sign_in'
#    sign_in users(:user_1)
#    post user_session_url
  end

  test "should get vote page" do
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get vote_path(@restaurant)

    assert_response :success
    assert_select "h3", text: "Vote on Splitting: Will or Won't They"
  end

  test "should return add when no restaurant" do
    get restaurants_url
    get "/search?name=" + "Name_0"

    assert_response :success
    assert_select "h3#not_found", text: "Didn't find the restaurant?"
  end

  test "should get by name" do
    get restaurants_url
    get "/search?name=" + "Name_3"

    assert_response :success
    assert_select "td#restaurant_name", text: "Name_3"
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
    get "/search?state=" + "TX"

    assert_response :success
    assert_select "td#restaurant_state", text: "TX"
  end

  test "should get by zip" do
    get restaurants_url
    get "/search?zip=" + "Zip_3"

    assert_response :success
    assert_select "td#restaurant_zip", text: "Zip_3"
  end

  test "should vote will 1 time" do
    get restaurants_url
    get "/search?name=" + "Name_3"

    assert_response :success
    assert_select "td#restaurant_name", text: "Name_3"

    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get "/restaurants/3/vote"
    get '/submit_vote?vote=will%203'

    get "/restaurants/3/vote"

    assert_response :success
    assert_select "p#will", text: "Will Split: 1 vote"
  end

  test "should vote will Multi times" do
    get restaurants_url
    get "/search?name=" + "Name_3"

    assert_response :success
    assert_select "td#restaurant_name", text: "Name_3"

    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get "/restaurants/3/vote"
    get '/submit_vote?vote=will%203'

    get "/restaurants/3/vote"
    get '/submit_vote?vote=will%203'

    get "/restaurants/3/vote"

    assert_response :success
    assert_select "p#will", text: "Will Split: 2 votes"
  end

  test "should vote wont 1 time" do
    get restaurants_url
    get "/search?name=" + "Name_3"

    assert_response :success
    assert_select "td#restaurant_name", text: "Name_3"

    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get "/restaurants/3/vote"
    get '/submit_vote?vote=wont%203'

    get "/restaurants/3/vote"

    assert_response :success
    assert_select "p#wont", text: "Won't Split: 1 vote"
  end

  test "should vote wont Multi times" do
    get restaurants_url
    get "/search?name=" + "Name_3"

    assert_response :success
    assert_select "td#restaurant_name", text: "Name_3"

    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get "/restaurants/3/vote"
    get '/submit_vote?vote=wont%203'

    get "/restaurants/3/vote"
    get '/submit_vote?vote=wont%203'

    get "/restaurants/3/vote"

    assert_response :success
    assert_select "p#wont", text: "Won't Split: 2 votes"
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

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
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

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
