class Api::V1::Auth::MeController < ApplicationController
  # include Secured
  before_action :authenticate

  # GET /me
  def show
    render json: { user: @current_user, status: 201 }
  end

  # private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.fetch(:user, {})
  # end
end
