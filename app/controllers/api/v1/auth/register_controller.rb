class Api::V1::Auth::RegisterController < ApplicationController
    def create
        @user = User.new(register_params)
        @user[:role] = 3

        if @user.save
            render json: @user, status: :created, message: "Successfully created account!"
        else
            render json: @user.errors, status: :unprocessable_entity, message: "Sign up failed!"
        end
    end

    private

    def register_params
        params[:register].permit(:email, :fullname, :password, :password_confirmation)
    end
end