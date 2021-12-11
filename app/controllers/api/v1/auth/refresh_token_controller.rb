class Api::V1::Auth::RefreshTokenController < ApplicationController
  # POST /v1/auth/refresh_token
  def create
    @current_user = User.find_by(refresh_token: params[:refresh_token])

    render json: { data: { access_token: generate_token }, status: 201, message: "Refresh token successfully!" }
  rescue StandardError
    response.status = 422
    render json: { message: 'Refresh token failed!' }
  end

  private

  def generate_token
    secret_key = Rails.application.secrets.secret_key_base

    payload_token = {
      user_id: @current_user.id,
      email: @current_user.email,
      role: @current_user.role,
      exp: Time.now.to_i + 60
    }
    JWT.encode(payload_token, secret_key)
  end
end
