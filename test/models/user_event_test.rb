require "test_helper"

class UserEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "valid user_event" do
    event = UserEvent.create({
                               data: {
                                 name: "key",
                                 event_type: "click"
                               }
                             })
    assert(UserEvent.all.count == 1)
  end

  test "invalid user_event" do
    UserEvent.create({
                       data: {
                         name: "key",
                         event_type: "foo"
                       }
                     })
    assert(UserEvent.all.count == 0)
  end

  test "missing key name" do

    UserEvent.create({
                       data: {
                         event_type: "click"
                       }
                     })
    assert(UserEvent.all.count == 0)
  end
  test "missing key event_type" do

    UserEvent.create({
                       data: {
                         name: "key"
                       }
                     })

    assert(UserEvent.all.count == 0)
  end

  test "user event is nil" do

    UserEvent.create({})

    assert(UserEvent.all.count == 0)
  end

  test "todays_stats" do
    UserEvent.create((1..5).map do
      {
        data: {
          name: "key",
          event_type: "click"
        }
      }
    end + (1..5).map do
      {
        data: {
          name: "key",
          event_type: "hover"
        }
      }
    end)

    assert UserEvent.todays_stats.to_json == [{ "click": 5 }, { "hover": 5 }].to_json
  end

  test "todays_stats only includes today" do
    UserEvent.create((1..5).map do
      {
        data: {
          name: "key",
          event_type: "click"
        },
        created_at: Date.yesterday
      }
    end + (1..5).map do
      {
        data: {
          name: "key",
          event_type: "hover"
        }
      }
    end)

    assert UserEvent.todays_stats.to_json == [{ "hover": 5 }].to_json
  end
end
