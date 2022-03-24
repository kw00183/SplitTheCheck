require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:one)
  end

  test "visiting the index" do
    visit restaurants_url
    assert_selector "h1", text: "Restaurants"
  end

  test "creating a Restaurant" do
    visit restaurants_url
    click_on "New Restaurant"

    fill_in "Address", with: @restaurant.address
    fill_in "City", with: @restaurant.city
    fill_in "Name", with: @restaurant.name
    fill_in "State", with: @restaurant.state
    fill_in "Will split count", with: @restaurant.will_split_count
    fill_in "Wont split count", with: @restaurant.wont_split_count
    fill_in "Zip", with: @restaurant.zip
    click_on "Create Restaurant"

    assert_text "Restaurant was successfully created"
    click_on "Back"
  end

  test "updating a Restaurant" do
    visit restaurants_url
    click_on "Edit", match: :first

    fill_in "Address", with: @restaurant.address
    fill_in "City", with: @restaurant.city
    fill_in "Name", with: @restaurant.name
    fill_in "State", with: @restaurant.state
    fill_in "Will split count", with: @restaurant.will_split_count
    fill_in "Wont split count", with: @restaurant.wont_split_count
    fill_in "Zip", with: @restaurant.zip
    click_on "Update Restaurant"

    assert_text "Restaurant was successfully updated"
    click_on "Back"
  end

  test "destroying a Restaurant" do
    visit restaurants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Restaurant was successfully destroyed"
  end
end
