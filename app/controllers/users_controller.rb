class UsersController < ApplicationController
  deserializable_resource :user, only: %i[update]
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    authorize!

    @users = User.all

    respond_to do |format|
      format.html
      format.json { render jsonapi: @users }
    end
  end

  # GET /users/1
  def show
    authorize! unless params[:id] == "me"

    respond_to do |format|
      format.html
      format.json { render jsonapi: @user }
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize! unless params[:id] == "me"

    if @user.update(user_params)
      redirect_to @user
    else
      render json: { error: @user.errors }, status: 400
    end
  end

  # DELETE /users/1
  def destroy
    authorize!

    if @user.destroy
      redirect_to users_url
    else
      render json: { error: @user.errors }, status: 400
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = params[:id] == "me" ? current_user : User.find(params[:id])
      raise ActiveRecord::RecordNotFound unless @user
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params
        .require(:user)
        .permit(:first_name, :last_name, :email, :pav_until, :driving_licence_since, :password)
    end
  end
