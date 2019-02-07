class PagesController < ApplicationController
  skip_before_action :authenticate_user, only: %i[index show]
  deserializable_resource :page, only: %i[create update]
  before_action :set_page, only: %i[show update destroy]

  # GET /pages
  def index
    @pages = Page.all

    render status: 200, jsonapi: @pages
  end

  # GET /pages/slug
  def show
    render status: 200, jsonapi: @page
  end

  # POST /pages
  def create
    authorize!

    @page = Page.new(page_params)

    verify_slug_unique; return if performed?

    if @page.save
      head 204
    else
      render status: 400, json: { error: @page.errors }
    end
  end

  # PATCH/PUT /pages/slug
  def update
    authorize!

    if @page.update(content: page_params[:content])
      render status: 200, jsonapi: @page
    else
      render status: 400, json: { error: @page.errors }
    end
  end

  # DELETE /pages/slug
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
    unless Page.exists?(slug: slug)
      render status: 404, json: { error: I18n.t('pages.not_found') } and return
    end

    @page = Page.find_by_slug(slug)
  end

  def page_params
    params.require(:page).permit(:slug, :content)
  end

  def slug
    params[:id]
  end

  def verify_slug_unique
    if Page.exists?(slug: page_params[:slug])
      render status: 400, json: { error: I18n.t('pages.slug_not_unique') } and return
    end
  end
end
