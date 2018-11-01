class AttendancesController < ApplicationController
  deserializable_resource :attendance, only: %i[create]
  before_action :set_attendance, only: %i[destroy]

  # GET /attendances
  def index
    authorize!

    render status: 400, json: { error: I18n.t('attendances.signature_trouble') } and return unless course_id.nil? ^ course_event_id.nil?

    if course_id
      render status: 400, json: { error: I18n.t('courses.not_found') } and return unless Course.exists?(course_id)
      @attendances = Attendance.with_course_id(course_id)
    else
      render status: 400, json: { error: I18n.t('course_events.not_found') } and return unless CourseEvent.exists?(course_event_id)
      @attendances = Attendance.find_by_course_event_id(course_event_id)
    end

    render status: 200, jsonapi: @attendances
  end

  # POST /attendances
  def create
    authorize!

    @attendance = Attendance.new(attendance_params)

    if @attendance.save
      render status: 200, jsonapi: @attendance
    else
      render status: 400, json: { error: @attendance.errors }
    end
  end

  # DELETE /attendances/1
  def destroy
    authorize!

    if @attendance.destroy
      head 204
    else
      render status: 400, json: { error: @attendance.errors }
    end
  end


  private

  def attendance_params
    params.require(:attendance).permit(:course_event_id, :participant_id)
  end

  def course_id
    params[:course_id]
  end

  def course_event_id
    params[:course_event_id]
  end

  def set_attendance
    render status: 404, json: { error: I18n.t('attendances.not_found') } and return unless Attendance.exists?(id)

    @attendance = Attendance.find(id)
  end

  def id
    params[:id]
  end
end
