class CourseCategoriesController < ApplicationController
  deserializable_resource :post, only: %i[create update]
  before_action :set_post, only: %i[show update destroy images]

  # GET /course_categories
  def index
    @course_categories = CourseCategory.all

    render status: 200, jsonapi: @course_categories
  end

  # GET /course_categories/1
  def show
    render status: 200, jsonapi: @course_category, include: :images
  end

  # POST /course_categories
  def create
    authorize!

    @course_category = CourseCategory.new(course_category_params)

    if @course_category.save
      render status: 201, jsonapi: @course_category
    else
      render status: 400, json: { error: @course_category.errors }
    end
  end

  # PATCH/PUT /course_categories/1
  def update
    authorize!

    if @course_category.update(course_category_params)
      render status: 200, jsonapi: @course_category
    else
      render status: 400, json: { error: @course_category.errors }
    end
  end

  # DELETE /course_categories/1
  def destroy
    authorize!

    if @course_category.destroy
      render status: 204, json: {}
    else
      render status: 400, json: { error: @course_category.errors }
    end
  end

  private

  def set_post
    render status: 404, json: { error: I18n.t('course_categories.not_found') } and return unless CourseCategory.exists?(id)

    @course_category = CourseCategory.find(id)
  end

  def course_category_params
    params.require(:post).permit(:category, :last_date)
  end

  def id
    params[:id]
  end
end
