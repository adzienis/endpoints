require "test_helper"

class UserEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "valid user_event" do
    UserEvent.create({
                       data: {
                         name: "key",
                         event_type: "click"
                       }
                     })
    assert(UserEvent.all.count == 1)
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
end
