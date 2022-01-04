class Api::V1::SessionsController < ApplicationController
  before_action :authenticate
  before_action :set_session, only: %i[show update destroy]

  # GET /sessions
  def index
    @sessions = Session.all.where(program_id: params[:program_id])

    render json: @sessions, status: 200
  end

  # GET /sessions/1
  def show
    render json: @session, status: 200
  end

  # POST /sessions
  def create
    @session = Session.new(session_params)

    if @session.save
      # TODO: create categories
      render json: @session, status: 201, message: 'Created session successfully!'
    else
      render json: @session.errors, status: 422
    end
  end

  # PATCH/PUT /sessions/1
  def update
    if @session.update(session_params)
      # TODO: update categories
      render json: @session
    else
      render json: @session.errors, status: 422
    end
  end

  # DELETE /sessions/1
  def destroy
    @session.destroy
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:id, :program_id, :title)
  end
end

