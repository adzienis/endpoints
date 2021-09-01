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
    assert_equal(["Data missing name"], @response.parsed_body["error"])
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

  test "todays_stats" do

    UserEvent.create((1..5).map do
      {
        data: {
          name: "key",
          event_type: "click"
        },
        created_at: Date.today
      }
    end + (1..5).map do
      {
        data: {
          name: "key",
          event_type: "hover"
        }
      }
    end)

    get todays_stats_path

    assert({
      "todays_stats": [{ "click": 5}, "hover": 5]
    }.as_json == @response.parsed_body)
  end

end
