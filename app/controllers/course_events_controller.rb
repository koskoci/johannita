class CourseEventsController < ApplicationController
  deserializable_resource :course_event, only: %i[create update]
  before_action :set_course_event, only: %i[update show]

  def index
    @course_events = CourseEvent.all

    render status: 200, jsonapi: @course_events
  end

  # GET /course_events/1
  def show
    render status: 200, jsonapi: @course_event
  end

  # POST /course_events
  def create
    authorize!

    @course_event = CourseEvent.new(course_event_params.except(:course_id))

    verify_course_exists; return if performed?
    @course_event.course = course

    if @course_event.save
      head 204
    else
      render status: 400, json: { error: @course_event.errors }
    end
  end

  # PATCH/PUT /course_events/1
  def update
    authorize!

    if @course_event.update(course_event_params)
      render status: 200, jsonapi: @course_event
    else
      render status: 400, json: { error: @course_event.errors }
    end
  end

  private

  def set_course_event
    unless CourseEvent.exists?(id)
      render status: 404, json: { error: I18n.t('course_events.not_found') } and return
    end

    @course_event = CourseEvent.find(id)
  end

  def course_event_params
    params.require(:course_event).permit(:title, :date, :course_id)
  end

  def id
    params[:id]
  end

  def verify_course_exists
    unless Course.exists?(course_id)
      render status: 400, json: { error: I18n.t('courses.not_found') } and return
    end
  end

  def course
    @_course ||= Course.find(course_id)
  end

  def course_id
    course_event_params[:course_id]
  end
end
