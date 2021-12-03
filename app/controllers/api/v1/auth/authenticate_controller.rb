class Api::V1::Auth::AuthenticateController < ApplicationController
  # skip_before_action :authenticate, only: :create
  before_action :load_user, only: :create

  def create
    @current_user = User.find_by email: params[:email]
    if @current_user.present? && @current_user.authenticate(params[:password])
      render json: { user: @current_user,
                     token: generate_token(params['remember']),
                     message: 'Login successfully!',
                     status: 200 }
    else
      render json: { message: 'Invalid email or password!' }
    end
  end

  def destroy
    render json: { message: 'Logout successfully!', status: 200 }
  end

  private

  def load_user
    # @current_user = User.find_by email: params[:email]
  end

  # login_token = SecureRandom.hex
  # exp = Time.now.to_i + 24 * 60 * 60

  def generate_token(remember)
    payload = {
      user_id: @current_user.id,
      email: @current_user.email
    }
    (payload[:exp] = Time.now.to_i + 60) unless remember
    secret = Rails.application.secrets.secret_key_base
    access_token = JWT.encode(payload, secret)

    @auth_token = {
      access_token: access_token,
      token_type: 'Bearer'
    }
  end
end
