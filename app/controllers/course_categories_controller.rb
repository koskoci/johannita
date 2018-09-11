class CourseCategoriesController < ApplicationController
  deserializable_resource :course_category, only: %i[create update]
  before_action :set_course_category, only: %i[show update destroy images]

  # GET /course_categories
  def index
    @course_categories = CourseCategory.includes(:course_events).each do |e|
      CourseCategories::UpdateLastDate.new(e).call
    end

    course_category_ids = CourseEvent.where(status: CourseEvent::ACTIVE_STATUSES).pluck(:course_category_id).uniq
    render status: 200, jsonapi: @course_categories
  end

  # GET /course_categories/1
  def show
    CourseCategories::UpdateLastDate.new(@course_category).call

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

    CourseCategories::UpdateLastDate.new(@course_category).call

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

  def set_course_category
    render status: 404, json: { error: I18n.t('course_categories.not_found') } and return unless CourseCategory.exists?(id)

    @course_category = CourseCategory.find(id)
  end

  def course_category_params
    params.require(:course_category).permit(:category, :title, :prerequisite_course_category_id)
  end

  def id
    params[:id]
  end
end
