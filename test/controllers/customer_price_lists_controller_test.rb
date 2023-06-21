require "test_helper"

class CustomerPriceListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_price_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get customer_price_lists_show_url
    assert_response :success
  end
end
