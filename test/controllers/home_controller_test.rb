require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get lab" do
    get home_lab_url
    assert_response :success
  end

end
