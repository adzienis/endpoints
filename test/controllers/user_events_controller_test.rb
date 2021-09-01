require "test_helper"

class UserEventsControllerTest < ActionDispatch::IntegrationTest

  test "no body" do
    post create_user_event_path
    assert_response 422
  end

  test "event missing values" do
    post create_user_event_path, params: {
      event: {
        event_type: "click"
      }
    }, as: :json

    assert_response 422
    assert_equal(["Data missing name"] , @response.parsed_body["error"])
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
