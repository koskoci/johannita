class PostsController < ApplicationController
  deserializable_resource :post, only: %i[create update]
  before_action :set_post, only: %i[show update destroy images]

  # GET /posts
  def index
    @posts = Post.all

    render status: 200, jsonapi: @posts
  end

  # GET /posts/1
  def show
    render status: 200, jsonapi: @post, include: :images
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
      head 204
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  # POST /posts/1/images
  def images
    authorize!

    if @post.images.attach(params[:post][:image])
      render status: 201, jsonapi: @post, include: :images
    else
      render status: 400, json: { error: @post.errors }
    end
  end

  private

  def set_post
    render status: 404, json: { error: I18n.t('posts.not_found') } and return unless Post.exists?(id)

    @post = Post.with_attached_images.find(id)
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def id
    params[:id]
  end
end
