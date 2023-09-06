class ApplicationController < ActionController::API
  def error_response(message:, status:)
    render json: { error: message }, status: status
  end
end
