require "test_helper"

class PriceListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get price_lists_index_url
    assert_response :success
  end
end
