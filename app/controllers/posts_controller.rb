class PostsController < ApplicationController
  deserializable_resource :post, only: %i[create update]
  before_action :set_post, only: %i[show edit update destroy select_image images]

  # GET /posts
  def index
    @posts = Post.all

    respond_to do |format|
      format.html
      format.json { render status: 200, jsonapi: @posts }
    end
  end

  # GET /posts/1
  def show
    respond_to do |format|
      format.html
      format.json { render status: 200, jsonapi: @post, include: :images, expose: {attachment_type: "images"} }
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

    if @post.update(post_params)
      render status: 200, jsonapi: @post
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  # DELETE /posts/1
  def destroy
    authorize!

    if @post.destroy
      render status: 204
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
    if @post.images.attach(params[:post][:image])
      render status: 201, jsonapi: @post, include: :images, expose: {attachment_type: "images"}
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.with_attached_images.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
