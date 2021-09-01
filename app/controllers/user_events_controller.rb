class UserEventsController < ApplicationController

  def todays_stats
    render json: {
      "todays_stats": UserEvent.todays_stats
    }
  end

  def create

    user_event = UserEvent.create({
                                    data: user_event_params
                                  })

    render json: { error: user_event.errors.full_messages }, status: 422 and return unless user_event.valid?

    render json: user_event, status: 201
  end

  def user_event_params
    params.require(:event).permit(:name, :event_type)
  end

end
