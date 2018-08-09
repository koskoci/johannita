class EventsController < ApplicationController
  deserializable_resource :event, only: [:create, :update]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :apply]

  # GET /events
  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.json { render jsonapi: @events }
    end
  end

  # GET /events/1
  def show
    respond_to do |format|
      format.html
      format.json { render jsonapi: @event }
    end
  end

  # POST /events/1/apply
  def apply
    @event.participants << participant unless already_added?

    respond_to do |format|
      format.html
      format.json { render jsonapi: @event, include: [participants: [:user] ] }
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    authorize! :create

    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    authorize! :update

    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
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
