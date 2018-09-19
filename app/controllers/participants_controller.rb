class ParticipantsController < ApplicationController
  deserializable_resource :participant, only: %i[update]
  before_action :set_participant, only: %i[update]

  # GET /participants
  def index
    authorize!

    render status: 400, json: { error: I18n.t('participants.course_event_id_missing') } and return unless course_event_id
    render status: 400, json: { error: I18n.t('course_events.not_found') } and return unless CourseEvent.exists?(course_event_id)
    render status: 400, json: { error: I18n.t('participants.course_event_cancelled') } and return if cancelled

    @participants = Participant.includes(:user).all

    render status: 200, jsonapi: @participants
  end

  # PATCH/PUT /participants/1
  def update
    authorize!

    render status: 400, json: { error: I18n.t('participants.course_event_cancelled') } and return if cancelled

    if @participant.update(participant_params)
      render status: 200, jsonapi: @participant
    else
      render status: 400, json: { error: @participant.errors }
    end
  end

  private

  def set_participant
    render status: 404, json: { error: I18n.t('participants.not_found') } and return unless Participant.exists?(id)

    @participant = Participant.includes(:user).find(id)
  end

  def participant_params
    params.require(:participant).permit(:attended, :passed)
  end

  def id
    params[:id]
  end

  def course_event_id
    params[:course_event_id] || @participant&.course_event&.id
  end

  def cancelled
    CourseEvent.find(course_event_id).status == "cancelled"
  end
end
