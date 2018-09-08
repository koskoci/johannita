class EventCategoriesController < ApplicationController
  deserializable_resource :post, only: %i[create update]
  before_action :set_post, only: %i[show update destroy images]

  # GET /event_categories
  def index
    @event_categories = EventCategory.all

    render status: 200, jsonapi: @event_categories
  end

  # GET /event_categories/1
  def show
    render status: 200, jsonapi: @event_category, include: :images
  end

  # POST /event_categories
  def create
    authorize!

    @event_category = EventCategory.new(event_category_params)

    if @event_category.save
      render status: 201, jsonapi: @event_category
    else
      render status: 400, json: { error: @event_category.errors }
    end
  end

  # PATCH/PUT /event_categories/1
  def update
    authorize!

    if @event_category.update(event_category_params)
      render status: 200, jsonapi: @event_category
    else
      render status: 400, json: { error: @event_category.errors }
    end
  end

  # DELETE /event_categories/1
  def destroy
    authorize!

    if @event_category.destroy
      render status: 204, json: {}
    else
      render status: 400, json: { error: @event_category.errors }
    end
  end

  private

  def set_post
    render status: 404, json: { error: I18n.t('event_categories.not_found') } and return unless EventCategory.exists?(id)

    @event_category = EventCategory.find(id)
  end

  def event_category_params
    params.require(:post).permit(:category, :last_date)
  end

  def id
    params[:id]
  end
end
