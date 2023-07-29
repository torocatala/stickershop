require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get hello message" do
    get "/hello/John"
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_equal "Hello John", json_response["msg"]
  end
end
