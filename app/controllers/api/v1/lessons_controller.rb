class Api::V1::LessonsController < ApplicationController
  before_action :authenticate
  before_action :set_lesson, only: %i[show update destroy]

  # GET /lessons
  def index
    @lessons = Lesson.all unless params.nil?
    @lessons = Lesson.all.where(session_id: params[:session_id]) if params[:session_id]
    @lessons = Lesson.all.where(category_id: params[:category_id]) if params[:category_id]
    @lessons = Lesson.all.where(unit_id: params[:unit_id]) if params[:unit_id]

    render json: @lessons, status: 200
  end

  # GET /lessons/1
  def show
    render json: @lesson, status: 200
  end

  # POST /lessons
  def create
    if params[:session_id]
      session = Session.find(params[:session_id])
      @lesson = session.lessons.new(lesson_params)
    end

    if params[:category_id]
      category = Category.find(params[:category_id])
      @lesson = category.lessons.new(lesson_params)
    end

    if params[:unit_id]
      unit = Unit.find(params[:unit_id])
      @lesson = unit.lessons.new(lesson_params)
    end

    if @lesson.save
      render json: @lesson, status: 201, message: 'Created lesson successfully!'
    else
      render json: @lesson.errors, status: 422
    end
  end

  # PATCH/PUT /lessons/1
  def update
    if @lesson.update(lesson_params)
      render json: @lesson
    else
      render json: @lesson.errors, status: 422
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:id, :session_id, :category_id, :unit_id, :title)
  end
end

