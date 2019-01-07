class PagesController < ApplicationController
  skip_before_action :authenticate_user, only: %i[index show]
  deserializable_resource :page, only: %i[create update]
  before_action :set_page, only: %i[show update destroy]

  # GET /pages
  def index
    @pages = Page.all

    render status: 200, jsonapi: @pages
  end

  # GET /pages/short_name
  def show
    render status: 200, jsonapi: @page
  end

  # POST /pages
  def create
    authorize!

    @page = Page.new(page_params)

    verify_short_name_unique; return if performed?

    if @page.save
      head 204
    else
      render status: 400, json: { error: @page.errors }
    end
  end

  # PATCH/PUT /pages/short_name
  def update
    authorize!

    if @page.update(content: page_params[:content])
      render status: 200, jsonapi: @page
    else
      render status: 400, json: { error: @page.errors }
    end
  end

  # DELETE /pages/short_name
  def destroy
    authorize!

    if @page.destroy
      head 204
    else
      render status: 400, json: { error: @page.errors }
    end
  end

  private

  def set_page
    unless Page.exists?(short_name: short_name)
      render status: 404, json: { error: I18n.t('pages.not_found') } and return
    end

    @page = Page.find_by_short_name(short_name)
  end

  def page_params
    params.require(:page).permit(:short_name, :content)
  end

  def short_name
    params[:id]
  end

  def verify_short_name_unique
    if Page.exists?(short_name: page_params[:short_name])
      render status: 400, json: { error: I18n.t('pages.short_name_not_unique') } and return
    end
  end
end
