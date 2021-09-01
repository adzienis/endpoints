class ApplicationController < ActionController::API

  rescue_from ActionController::ParameterMissing do |e|
    render json: {
      error: e.message
    }, status: 422
  end


end
