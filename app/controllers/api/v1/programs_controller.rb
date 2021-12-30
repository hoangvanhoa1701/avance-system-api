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

    render json: @programs, status: 200
  end

  # GET /programs/1
  def show
    render json: @program, status: 200
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
      update_sessions
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

  def session_params(session)
    session.permit(:title, :categories)
  end

  def category_params(category)
    category.permit(:title)
  end

  def create_sessions
    params[:sessions].each do |session|
      session_current = @program.sessions.create(session_params(session))
      create_categories(session_current, session) if session[:categories]
    end
  end

  def update_sessions
    params[:sessions].each do |session|
      session_current = @program.sessions.find(session[:id]).update(session_params(session))
      # update_categories(session_current, session) if session[:categories]
    end
  end

  def create_categories(session_current, session)
    session[:categories].each do |category|
      @category = session_current.categories.create(category_params(category))
    end
  end

  # def update_categories(session_current, session)
  #   session[:categories].each do |category|
  #     @category = session_current.categories.create(category_params(category))
  #   end
  # end
end

