require "application_system_test_case"

class VoteHistoriesTest < ApplicationSystemTestCase
  setup do
    @vote_history = vote_histories(:one)
  end

  test "visiting the index" do
    visit vote_histories_url
    assert_selector "h1", text: "Vote Histories"
  end

  test "creating a Vote history" do
    visit vote_histories_url
    click_on "New Vote History"

    fill_in "Restaurant", with: @vote_history.restaurant_id
    fill_in "User", with: @vote_history.user_id
    check "Vote split" if @vote_history.vote_split
    click_on "Create Vote history"

    assert_text "Vote history was successfully created"
    click_on "Back"
  end

  test "updating a Vote history" do
    visit vote_histories_url
    click_on "Edit", match: :first

    fill_in "Restaurant", with: @vote_history.restaurant_id
    fill_in "User", with: @vote_history.user_id
    check "Vote split" if @vote_history.vote_split
    click_on "Update Vote history"

    assert_text "Vote history was successfully updated"
    click_on "Back"
  end

  test "destroying a Vote history" do
    visit vote_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vote history was successfully destroyed"
  end
end
