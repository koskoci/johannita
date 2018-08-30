class PostsController < ApplicationController
  deserializable_resource :post, only: %i[create update]
  before_action :set_post, only: %i[show edit update destroy select_image images]

  # GET /posts
  def index
    @posts = Post.all

    render status: 200, jsonapi: @posts
  end

  # GET /posts/1
  def show
    if @post
      render status: 200, jsonapi: @post, include: :images, expose: {attachment_type: "images"}
    else
      render status: 404, json: { error: I18n.t('posts.not_found') }
    end
  end

  # POST /posts
  def create
    authorize!

    @post = Post.new(post_params)

    if @post.save
      render status: 201, jsonapi: @post
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  # PATCH/PUT /posts/1
  def update
    authorize!

    render status: 404, json: { error: I18n.t('posts.not_found') } and return unless Post.exists?(params[:id])

    if @post.update(post_params)
      render status: 200, jsonapi: @post
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  # DELETE /posts/1
  def destroy
    authorize!

    render status: 404, json: { error: I18n.t('posts.not_found') } and return unless Post.exists?(params[:id])

    if @post.destroy
      render status: 204, json: {}
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  # GET /posts/1/select_image
  def select_image
    # Server-side rendering for testing purposes
  end

  # POST /posts/1/images
  def images
    authorize!

    render status: 404, json: { error: I18n.t('posts.not_found') } and return unless Post.exists?(params[:id])

    if @post.images.attach(params[:post][:image])
      render status: 201, jsonapi: @post, include: :images, expose: {attachment_type: "images"}
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      id = params[:id]
      @post = Post.with_attached_images.find(id) if Post.exists?(id)
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
