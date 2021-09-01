class ApplicationController < ActionController::API

  rescue_from ActionController::ParameterMissing do |e|
    render json: nil, status: 422
  end


end
