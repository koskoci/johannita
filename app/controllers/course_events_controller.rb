class CourseEventsController < ApplicationController
  deserializable_resource :course_event, only: %i[create update]
  before_action :set_course_event, only: %i[show edit update destroy apply confirm cancel]

  def index
    @course_events = CourseEvent.all

    render status: 200, jsonapi: @course_events, expose: { user: current_user }
  end

  # GET /course_events/1
  def show
    render status: 200, jsonapi: @course_event, include: :participants, expose: { user: current_user }
  end

  # POST /course_events
  def create
    authorize!

    @course_event = CourseEvent.new(course_event_params.except(:category))

    verify_course_category_exists; return if performed?
    update_category

    if @course_event.save
      head 204
    else
      render status: 400, json: { error: @course_event.errors }
    end
  end

  # PATCH/PUT /course_events/1
  def update
    authorize!

    @course_event.update_columns(course_event_params.except(:category).to_h)

    if course_event_params[:category]
      verify_course_category_exists; return if performed?
      update_category
    end

    if @course_event.save
      render status: 200, jsonapi: @course_event, expose: { user: current_user }
    else
      render status: 400, json: { error: @course_event.errors }
    end
  end

  # POST /course_events/1/apply
  def apply
    @course_event.participants << current_participant unless already_applied?

    render status: 200, jsonapi: @course_event, include: :participants
  end

  # PATCH /course_events/1/confirm
  def confirm
    authorize!

    render status: 200, jsonapi: @course_event and return if @course_event.status == "confirmed"

    @course_event.update_attribute(:status, "confirmed")
    EventConfirmedWorker.perform_async(@course_event.id)

    render status: 200, jsonapi: @course_event
  end

  # PATCH /course_events/1/cancel
  def cancel
    authorize!

    render status: 200, jsonapi: @course_event and return if @course_event.status == "cancelled"

    @course_event.update_attribute(:status, "cancelled")
    EventCancelledWorker.perform_async(@course_event.id)

    render status: 200, jsonapi: @course_event
  end

  private

  def set_course_event
    render status: 404, json: { error: I18n.t('course_events.not_found') } and return unless CourseEvent.exists?(id)

    @course_event = CourseEvent.includes(:users, :course_category).find(id)
  end

  def course_event_params
    params.require(:course_event).permit(:title, :category, :date, :apply_by)
  end

  def already_applied?
    @course_event.participants.where(user_id: current_user.id, course_event_id: @course_event.id).present?
  end

  def current_participant
    @_participant ||= Participant.new(user_id: current_user.id, course_event_id: @course_event.id)
  end

  def id
    params[:id]
  end

  def update_category
    @course_event.course_category = CourseCategory.find_by(category: course_event_params[:category])
  end

  def verify_course_category_exists
    render status: 400, json: { error: I18n.t('course_categories.not_found') } and return unless CourseCategory.where(category: course_event_params[:category]).exists?
  end
end
