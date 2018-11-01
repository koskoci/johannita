class AttendancesController < ApplicationController
  deserializable_resource :attendance, only: %i[create]
  before_action :set_attendance, only: %i[destroy]

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

  def set_attendance
    render status: 404, json: { error: I18n.t('attendances.not_found') } and return unless Attendance.exists?(id)

    @attendance = Attendance.find(id)
  end

  def id
    params[:id]
  end
end
