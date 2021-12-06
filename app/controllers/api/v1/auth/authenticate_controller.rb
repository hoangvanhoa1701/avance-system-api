class Api::V1::Auth::AuthenticateController < ApplicationController
  # skip_before_action :authenticate, only: :create
  before_action :load_user, only: :create

  def create
    if @current_user.present? && @current_user.authenticate(params[:password])
      render json: { user: @current_user,
                     token: generate_token(params['remember']),
                     message: 'Login successfully!',
                     status: 200 }
    else
      render json: { message: 'Incorrect username or password!', status: 400 }
    end
  end

  def destroy
    render json: { message: 'Logout successfully!', status: 200 }
  end

  private

  def load_user
    @current_user = User.find_by email: params[:email]
  end

  # login_token = SecureRandom.hex

  def generate_token(remember)
    secret_key = Rails.application.secrets.secret_key_base

    payload_token = {
      user_id: @current_user.id,
      email: @current_user.email,
      role: @current_user.role,
      exp: Time.now.to_i + 60
    }
    access_token = JWT.encode(payload_token, secret_key)

    payload_refresh_refresh = {
      user_id: @current_user.id,
      exp: Time.now.to_i + 24 * 60 * 60
    }
    (payload_refresh_refresh[:exp] = Time.now.to_i + 30 * 24 * 60 * 60) if remember
    refresh_token = JWT.encode(payload_refresh_refresh, secret_key)

    @current_user.update(refresh_token: refresh_token)

    @auth_token = {
      access_token: access_token,
      refresh_token: refresh_token,
      token_type: 'Bearer'
    }
  end
end
