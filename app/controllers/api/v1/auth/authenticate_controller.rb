class Api::V1::Auth::AuthenticateController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      # session[:user_id] = user.id # handle responve token auth_token

      render json: { user: @user, token: @token, message: "Login successfully!" }
    else
      render json: { message: "Invalid email or password!" }
    end
  end
end