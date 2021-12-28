class Api::V1::ProgramsController < ApplicationController
  before_action :authenticate
  before_action :set_user, only: %i[show update destroy]

  # GET /programs
  def index
    @programs = if @current_user.role == :admin
                  Program.all
                else
                  Program.all.where(created_by: @current_user.id)
                end

    render json: @programs
  end

  # GET /programs/1
  def show
    render json: @program
  end

  # POST /programs
  def create
    @program = Program.new(program_params)
    @program.created_by = @current_user.id

    if params[:sessions].empty?
      render json: { status: 422, message: 'Sessions is empty!' },
             status: 422
      return
    end

    if @program.save
      create_sessions

      render json: @program, status: 201, message: 'Created program successfully!'
    else
      render json: @program.errors, status: 422
    end
  end

  # PATCH/PUT /programs/1
  def update
    if @program.update(program_params)
      render json: @program
    else
      render json: @program.errors, status: 422
    end
  end

  # DELETE /programs/1
  def destroy
    @program.destroy
  end

  private

  def set_user
    @program = Program.find(params[:id])

    render json: { message: 'Do not have permission!' }, status: 403 if @program.created_by != @current_user.id
  end

  def program_params
    params.require(:program).permit(:title, :sessions)
  end

  def create_sessions
    params[:sessions].each do |session|
      @program.sessions.create(session_params(session))
    end
  end

  def session_params(session)
    session.permit(:title)
  end
end

