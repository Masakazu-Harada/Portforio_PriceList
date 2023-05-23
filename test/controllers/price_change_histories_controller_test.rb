require "test_helper"

class PriceChangeHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get price_change_histories_index_url
    assert_response :success
  end
end
