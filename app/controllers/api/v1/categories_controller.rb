class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate
  before_action :set_category, only: %i[show update destroy]

  # GET /categories
  def index
    @categories = Category.all.where(session_id: params[:session_id])

    render json: @categories, status: 200
  end

  # GET /categories/1
  def show
    render json: @category, status: 200
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      # TODO: create categories
      render json: @category, status: 201, message: 'Created category successfully!'
    else
      render json: @category.errors, status: 422
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      # TODO: update categories
      render json: @category
    else
      render json: @category.errors, status: 422
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:id, :session_id, :title)
  end
end

