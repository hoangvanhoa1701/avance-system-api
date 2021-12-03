class Api::V1::UsersController < ApplicationController
  before_action :authenticate
  before_action :set_user, only: %i[show update destroy]
  # GET /users
  def index
    @users = User.all

    render json: @users
    # render json: @users, only: [:username]
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    # @user = User.new(user_params);
    @user = User.new({ role: params[:role],
                       email: params[:email],
                       fullname: params[:fullname],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation]
                     })

    if @user.save
      render json: @user, status: :created, message: "Created account successfully!"
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :fullname, :password, :password_confirmation)
    # params.fetch(:user, {})
  end
end

