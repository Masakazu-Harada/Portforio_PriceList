require "test_helper"

class ProductSuppliersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_suppliers_index_url
    assert_response :success
  end

  test "should get show" do
    get product_suppliers_show_url
    assert_response :success
  end
end
