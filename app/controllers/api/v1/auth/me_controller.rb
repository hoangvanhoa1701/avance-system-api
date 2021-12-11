class Api::V1::Auth::MeController < ApplicationController
  # include Secured
  before_action :authenticate

  # GET /me
  def show
    render json: { data: { user: @current_user }, status: 200, message: "Get profile successfully!" }
  end

  # private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.fetch(:user, {})
  # end
end
