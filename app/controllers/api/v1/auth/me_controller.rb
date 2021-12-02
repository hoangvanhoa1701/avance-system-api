class Api::V1::Auth::MeController < ApplicationController
  include Secured

  # GET /me
  def show
    render json: @user
  end

  # private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def user_params
  #   params.fetch(:user, {})
  # end
end
