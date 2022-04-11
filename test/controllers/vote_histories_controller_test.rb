require "test_helper"

class VoteHistoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @vote_history = vote_histories(:one)
  end

  test "should get index" do
    get vote_histories_url
    assert_response :success
  end

  test "should get new" do
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    get new_vote_history_url
    assert_response :success
  end

  test "should create vote_history" do
    get '/users/sign_in'
    sign_in users(:user_1)
    post user_session_url

    assert_difference('VoteHistory.count') do
      post vote_histories_url, params: { vote_history: { restaurant_id: @vote_history.restaurant_id, user_id: @vote_history.user_id, vote_split: @vote_history.vote_split } }
    end

    assert_redirected_to vote_history_url(VoteHistory.last)
  end

  test "should show vote_history" do
    get vote_history_url(@vote_history)
    assert_response :success
  end

  test "should get edit" do
#    get edit_vote_history_url(@vote_history)
#    assert_response :success
  end

  test "should update vote_history" do
#    patch vote_history_url(@vote_history), params: { vote_history: { restaurant_id: @vote_history.restaurant_id, user_id: @vote_history.user_id, vote_split: @vote_history.vote_split } }
#    assert_redirected_to vote_history_url(@vote_history)
  end

  test "should destroy vote_history" do
#    assert_difference('VoteHistory.count', -1) do
#      delete vote_history_url(@vote_history)
#    end

#    assert_redirected_to vote_histories_url
  end
end
