class Api::V1::RolesController < ApplicationController
  before_action :authenticate
  before_action :role_admin, only: %i[index index_admin update destroy]

  # GET /roles/all
  def index
    @users_admin = User.all.where(role: :admin)
    @users_contentadmin = User.all.where(role: :contentadmin)
    @users_educator = User.all.where(role: :educator)
    @users_usernone = User.all.where(role: :usernone)

    render json: { users_admin: @users_admin,
                   users_contentadmin: @users_contentadmin,
                   users_educator: @users_educator,
                   users_usernone: @users_usernone },
           status: 200
  end

  # GET /roles/admin
  def index_admin
    @users_admin = User.all.where(role: :admin)
    render json: @users_admin, status: 200
  end

  # GET /roles/contentadmin
  def index_contentadmin
    @users_contentadmin = User.all.where(role: :contentadmin)
    render json: @users_contentadmin, status: 200
  end

  # GET /roles/educator
  def index_educator
    @users_educator = User.all.where(role: :educator)
    render json: @users_educator, status: 200
  end

  # GET /roles/usernone
  def index_usernone
    @users_usernone = User.all.where(role: :usernone)
    render json: @users_usernone, status: 200
  end

  # PATCH/PUT /roles
  def update
    params[:admin]&.each do |email|
      User.find_by(email: email).update(role: :admin)
    end

    params[:contentadmin]&.each do |email|
      User.find_by(email: email).update(role: :contentadmin)
    end

    if params[:educator] && params[:program_ids]
      params[:educator].each do |email|
        user = User.find_by(email: email).update(role: :educator)

        update_program(user)
      end
    end

    render json: { message: 'Update roles successfully!' }, status: 200
  rescue StandardError
    render json: { message: 'Update roles failed!' }, status: 422
  end

  # DELETE /roles/1
  def destroy
    User.find(params[:id]).update(role: :usernone)
  end

  private

  def role_admin
    render json: { message: 'Forbidden!' }, status: 403 if @current_user.role != 'admin'
  end

  # def update_admin
  # # User.find_by(email: email).update(role: :educator)
  # end

  def update_user_program(user)
    params[:program_ids].each do |id|
      # TODO: update program_ids
      # user.programs
    end
  end
end