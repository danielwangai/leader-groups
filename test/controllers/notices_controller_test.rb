require 'test_helper'

class NoticesControllerTest < ActionDispatch::IntegrationTest
  test "should get incoming" do
    get notices_incoming_url
    assert_response :success
  end

end
