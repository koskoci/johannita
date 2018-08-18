class PostsController < ApplicationController
  deserializable_resource :post, only: [:create]#, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :select_image, :upload_image]

  # GET /posts
  def index
    @posts = Post.all

    respond_to do |format|
      format.html
      format.json { render jsonapi: @posts }
    end
  end

  # GET /posts/1
  def show
    respond_to do |format|
      format.html
      format.json { render jsonapi: @post }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    authorize! :create

    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    authorize! :update

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  # GET /posts/1/images
  def select_image
  end

  # PATCH /posts/1/images
  def upload_image
    Post.transaction do
      @post.image.purge
      if @post.update(image: params[:post][:image])
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
