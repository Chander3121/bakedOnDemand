require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get dashboard_show_url
    assert_response :success
  end

  test "should get profile" do
    get dashboard_profile_url
    assert_response :success
  end

  test "should get orders" do
    get dashboard_orders_url
    assert_response :success
  end

  test "should get addresses" do
    get dashboard_addresses_url
    assert_response :success
  end
end
