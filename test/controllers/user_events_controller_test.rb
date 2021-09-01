require "test_helper"

class UserEventsControllerTest < ActionDispatch::IntegrationTest

  test "no body" do
    post create_user_event_path
    assert_response 422
  end

  test "valid event" do
    post create_user_event_path, params: {
      event: {
        name: "foo",
        event_type: "click"
      }
    }, as: :json
    assert_response 201
  end
end
