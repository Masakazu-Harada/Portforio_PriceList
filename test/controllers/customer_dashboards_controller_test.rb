require "test_helper"

class CustomerDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_dashboards_index_url
    assert_response :success
  end
end
