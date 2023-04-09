require "test_helper"

class PricelistControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pricelist_index_url
    assert_response :success
  end
end
