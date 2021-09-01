class UserEventsController < ApplicationController

  def create

    user_event = UserEvent.create({
                                    data: user_event_params
                                  })

    render json: user_event, status: 422 and return unless user_event.valid?

    render json: user_event, status: 201
  end

  def user_event_params
    params.require(:event).permit(:name, :event_type)
  end

end
