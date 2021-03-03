require 'test_helper'

class PlateausControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plateaus_new_url
    assert_response :success
  end

end
