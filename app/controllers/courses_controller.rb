class CoursesController < ApplicationController
  deserializable_resource :course, only: %i[create update]
  before_action :set_course, only: %i[update confirm cancel]
  before_action :set_course_with_users, only: %i[show apply]

  def index
    @courses = Course.all

    render status: 200, jsonapi: @courses, expose: { user: current_user }
  end

  # GET /courses/1
  def show
    render status: 200, jsonapi: @course, include: :participants, expose: { user: current_user }
  end

  # POST /courses
  def create
    authorize!

    @course = Course.new(course_params.except(:category))

    verify_course_category_exists; return if performed?
    update_category

    if @course.save
      head 204
    else
      render status: 400, json: { error: @course.errors }
    end
  end

  # PATCH/PUT /courses/1
  def update
    authorize!

    @course.update_columns(course_params.except(:category).to_h)

    old_category = @course.course_category

    if course_params[:category]
      verify_course_category_exists; return if performed?
      update_category
    end

    if @course.save
      render status: 200, jsonapi: @course, expose: { user: current_user }
    else
      render status: 400, json: { error: @course.errors }
    end
  end

  # POST /courses/1/apply
  def apply
    @course.participants << current_participant unless already_applied?

    render status: 200, jsonapi: @course, include: :participants
  end

  # PATCH /courses/1/confirm
  def confirm
    authorize!

    render status: 200, jsonapi: @course and return if @course.status == "confirmed"

    @course.update_attribute(:status, "confirmed")
    CourseConfirmedWorker.perform_async(@course.id)

    render status: 200, jsonapi: @course
  end

  # PATCH /courses/1/cancel
  def cancel
    authorize!

    render status: 200, jsonapi: @course and return if @course.status == "cancelled"

    @course.update_attribute(:status, "cancelled")
    CourseCancelledWorker.perform_async(@course.id)

    render status: 200, jsonapi: @course
  end

  private

  def set_course
    render status: 404, json: { error: I18n.t('courses.not_found') } and return unless Course.exists?(id)

    @course = Course.find(id)
  end

  def set_course_with_users
    render status: 404, json: { error: I18n.t('courses.not_found') } and return unless Course.exists?(id)

    @course = Course.includes(:users).find(id)
  end

  def course_params
    params.require(:course).permit(:title, :category, :date, :apply_by)
  end

  def already_applied?
    @course.participants.where(user_id: current_user.id, course_id: @course.id).present?
  end

  def current_participant
    @_participant ||= Participant.new(user_id: current_user.id, course_id: @course.id)
  end

  def id
    params[:id]
  end

  def verify_course_category_exists
    render status: 400, json: { error: I18n.t('course_categories.not_found') } and return unless course_category
  end

  def course_category
    @_course_category ||= CourseCategory.find_by_category(course_params[:category])
  end

  def update_category
    @course.course_category = course_category
  end
end
