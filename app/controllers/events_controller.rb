class EventsController < ApplicationController
  deserializable_resource :event, only: %i[create update]
  before_action :set_event, only: %i[show edit update destroy apply confirm cancel]

  def index
    @events = Event.all

    render status: 200, jsonapi: @events
  end

  # GET /events/1
  def show
    render status: 200, jsonapi: @event, include: :participants
  end

    # POST /events
  def create
    authorize!

    @event = Event.new(event_params.except(:category))

    verify_course_category_exists; return if performed?
    update_category

    if @event.save
      render status: 201, jsonapi: @event
    else
      render status: 400, json: { error: @event.errors }
    end
  end

  # PATCH/PUT /events/1
  def update
    authorize!

    @event.update_columns(event_params.except(:category).to_h)

    if event_params[:category]
      verify_course_category_exists; return if performed?
      update_category
    end

    if @event.save
      render status: 200, jsonapi: @event
    else
      render status: 400, json: { error: @event.errors }
    end
  end

  # POST /events/1/apply
  def apply
    @event.participants << current_participant unless already_applied?

    render status: 200, jsonapi: @event, include: :participants
  end

  # PATCH /events/1/confirm
  def confirm
    authorize!

    render status: 200, jsonapi: @event and return if @event.status == "confirmed"

    @event.update_attribute(:status, "confirmed")
    @event.participants.includes(:user).each do |participant|
      EventConfirmedMailer.with(user: participant.user, event: @event).call.deliver_now
    end

    render status: 200, jsonapi: @event
  end

  # PATCH /events/1/cancel
  def cancel
    authorize!

    render status: 200, jsonapi: @event and return if @event.status == "cancelled"

    @event.update_attribute(:status, "cancelled")
    @event.participants.includes(:user).each do |participant|
      EventCancelledMailer.with(user: participant.user, event: @event).call.deliver_now
    end

    render status: 200, jsonapi: @event
  end

  private

  def set_event
    render status: 404, json: { error: I18n.t('events.not_found') } and return unless Event.exists?(id)

    @event = Event.includes(:users, :course_category).find(id)
  end

  def event_params
    params.require(:event).permit(:title, :category, :date, :apply_by)
  end

  def already_applied?
    @event.participants.where(user_id: current_user.id, event_id: @event.id).present?
  end

  def current_participant
    @_participant ||= Participant.new(user_id: current_user.id, event_id: @event.id)
  end

  def id
    params[:id]
  end

  def update_category
    @event.course_category = CourseCategory.find_by(category: event_params[:category])
  end

  def verify_course_category_exists
    render status: 400, json: { error: I18n.t('course_categories.not_found') } and return unless CourseCategory.where(category: event_params[:category]).exists?
  end
end
