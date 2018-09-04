class EventsController < ApplicationController
  deserializable_resource :event, only: %i[create update]
  before_action :set_event, only: %i[show edit update destroy apply confirm cancel]

  # GET /events
  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.json { render status: 200, jsonapi: @events }
    end
  end

  # GET /events/1
  def show
    respond_to do |format|
      format.html
      format.json { render status: 200, jsonapi: @event, include: :participants }
    end
  end

  # POST /events/1/apply
  def apply
    @event.participants << participant unless already_added?

    respond_to do |format|
      format.html
      format.json { render status: 200, jsonapi: @event, include: :participants }
    end
  end

  # PATCH /events/1/confirm
  def confirm
    authorize!

    redirect_to(@event, notice: 'Event already confirmed') and return if @event.status == "confirmed"

    @event.update_attribute(:status, "confirmed")
    @event.participants.includes(:user).each do |participant|
      EventConfirmedMailer.with(user: participant.user, event: @event).call.deliver_now
    end

    respond_to do |format|
      format.html
      format.json { render status: 200, jsonapi: @event, include: :participants }
    end
  end

  # PATCH /events/1/cancel
  def cancel
    authorize!

    redirect_to(@event, notice: 'Event already cancelled') and return if @event.status == "cancelled"

    @event.update_attribute(:status, "cancelled")
    @event.participants.includes(:user).each do |participant|
      EventCancelledMailer.with(user: participant.user, event: @event).call.deliver_now
    end

    respond_to do |format|
      format.html
      format.json { render status: 200, jsonapi: @event, include: :participants }
    end
  end

  # POST /events
  def create
    authorize!

    @event = Event.new(event_params)

    if @event.save
      render status: 201, jsonapi: @event
    else
      render status: 400, json: { error: @event.errors }
    end
  end

  # PATCH/PUT /events/1
  def update
    authorize!

    if @event.update(event_params)
      render status: 200, jsonapi: @event
    else
      render status: 400, json: { error: @event.errors }
    end
  end

  private
    def set_event
      @event = Event.includes(:users).find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :category, :date)
    end

    def already_added?
      @event.participants.where(user_id: current_user.id, event_id: @event.id).present?
    end

    def participant
      @_participant ||= Participant.new(user_id: current_user.id, event_id: @event.id)
    end
end
