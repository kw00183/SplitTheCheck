require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:fix_1)
  end

  test "visiting the index" do
    visit restaurants_url
    assert_selector "h1", text: "To Split or Not To Split"
  end

  test "creating a Restaurant" do
    visit restaurants_url

    fill_in "Name", with: "Name_0"
    click_on "Search"

    click_on "Add Restaurant"

    fill_in :address, with: "Address_0"
    fill_in :city, with: "City_0"
    fill_in :name, with: "Name_0"

    find('#restaurant_state').select('TX')

    fill_in :zip, with: "Zip_0"
    click_on "Create Restaurant"

    assert_text "Restaurant was successfully created"
  end

  test "updating a Restaurant" do
    visit restaurants_url

    fill_in "Name", with: "Name_1"
    click_on "Search"

    click_on "Edit", match: :first

    fill_in :address, with: @restaurant.address
    fill_in :city, with: @restaurant.city
    fill_in :name, with: @restaurant.name

    find('#restaurant_state').select('TX')

    fill_in :zip, with: @restaurant.zip
    click_on "Update Restaurant"

    assert_text "Restaurant was successfully updated"
  end

  test "destroying a Restaurant" do
#    visit restaurants_url
#    page.accept_confirm do
#      click_on "Destroy", match: :first
#    end

#    assert_text "Restaurant was successfully destroyed"
  end
end
