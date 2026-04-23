require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get success" do
    get orders_success_url
    assert_response :success
  end
end
