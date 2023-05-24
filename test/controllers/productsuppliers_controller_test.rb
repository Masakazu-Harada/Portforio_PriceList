require "test_helper"

class ProductsuppliersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get productsuppliers_index_url
    assert_response :success
  end

  test "should get show" do
    get productsuppliers_show_url
    assert_response :success
  end
end
