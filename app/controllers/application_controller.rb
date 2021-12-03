class ApplicationController < ActionController::API
  def authenticate
    authorization_header = request.headers['Authorization']
    token = authorization_header.split(' ').last
    secret = Rails.application.secrets.secret_key_base
    decoded_token = JWT.decode(token, secret)

    @current_user = User.find(decoded_token[0]['user_id'])
  rescue StandardError
  # rescue JWT::ImmatureSignature
    # Handle expired token, e.g. logout user or deny access
    render json: { message: 'Login failed.' }
  end
end
