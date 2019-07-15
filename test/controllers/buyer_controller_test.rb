require 'test_helper'

class BuyerControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get buyer_page_url
    assert_response :success
  end

end
