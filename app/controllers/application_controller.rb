class ApplicationController < ActionController::API
  def authenticate
    authorization_header = request.headers['Authorization']
    token = authorization_header.split(' ').last
    secret = Rails.application.secrets.secret_key_base
    decoded_token = JWT.decode(token, secret)
    
    @current_user = User.find(decoded_token[0]['user_id'])
    if @current_user[:refresh_token].nil?
      render json: { message: 'Unauthorized!', status: 401 }
    end
  rescue StandardError
  # rescue JWT::ImmatureSignature
    # Handle expired token, e.g. logout user or deny access
    response.status = 401
    render json: { message: 'Unauthorized!', status: 401 }
  end
end
