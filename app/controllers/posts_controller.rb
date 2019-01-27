class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[index show]
  deserializable_resource :post, only: %i[create update]
  before_action :set_post, only: %i[update destroy show]

  # GET /posts
  def index
    @posts = Post.all

    render status: 200, jsonapi: @posts
  end

  # GET /posts/1
  def show
    render status: 200, jsonapi: @post
  end

  # POST /posts
  def create
    authorize!

    @post = Post.new(post_params)

    if @post.save
      head 204
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

  private

  def set_post
    render status: 404, json: { error: I18n.t('posts.not_found') } and return unless Post.exists?(id)

    @post = Post.find(id)
  end

  def post_params
    params.require(:post).permit(:title, :content, :thumbnail_url, :blurb)
  end

  def id
    params[:id]
  end
end
