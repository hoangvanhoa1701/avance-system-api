class Api::V1::Auth::AuthenticateController < ApplicationController
  # before_action :authenticate, only: :destroy
  before_action :load_user, only: :create

  def create
    if @current_user.present? && @current_user.authenticate(params[:password])
      render json: { data: { user: @current_user, token: generate_token(params['remember']) },
                     status: 200, message: 'Login successfully!' }
    else
      # TODO: Handle error
      render json: { status: 422, message: 'Incorrect username or password!' },
             status: 422
    end

  end

  def destroy
    @current_user = User.find_by(refresh_token: params[:refresh_token])
    @current_user.update(refresh_token: nil)
    render json: { status: 200, message: 'Logout successfully!' }
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
