class Api::V1::Auth::RegisterController < ApplicationController
  def create
    @user = User.new(register_params)
    @user[:role] = 3

    if @user.save
      render json: { data: @user, status: 201, message: "Sign up successfully!" }
    else
      response.status = 422
      render json: @user.errors, status: 422, message: "Sign up failed!"
    end
  end

  private

  def register_params
    params[:register].permit(:email, :fullname, :password, :password_confirmation)
  end
end
