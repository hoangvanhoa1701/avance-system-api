class Api::V1::Auth::MeController < ApplicationController
  # include Secured
  before_action :authenticate

  # GET /me
  def show
    render json: @current_user
  end

  # private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.fetch(:user, {})
  # end
end
