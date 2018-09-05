class UsersController < ApplicationController
  deserializable_resource :user, only: %i[update]
  before_action :set_user, only: %i[show update destroy curriculum_vitaes cover_letters]

  # GET /users
  def index
    authorize!

    @users = User.all

    render status: 200, jsonapi: @users
  end

  # GET /users/1
  def show
    authorize! unless id == "me"

    render status: 200, jsonapi: @user, include: %i[curriculum_vitae cover_letter]
  end

  # PATCH/PUT /users/1
  def update
    authorize! unless id == "me"

    if @user.update(user_params)
      render status: 200, jsonapi: @user
    else
      render status: 400, json: { error: @user.errors }
    end
  end

  # DELETE /users/1
  def destroy
    authorize!

    if @user.destroy
      render status: 204, json: {}
    else
      render status: 400, json: { error: @user.errors }
    end
  end

  # GET /users/1/select_curriculum_vitae
  def select_curriculum_vitae
    # Server-side rendering for testing purposes
  end

  # POST /users/1/curriculum_vitaes
  def curriculum_vitaes
    authorize! unless id == "me"

    @user.curriculum_vitae.attach(params[:user][:curriculum_vitae])
    render status: 201, jsonapi: @user, include: %i[curriculum_vitae cover_letter]
  end

  # POST /users/1/cover_letters
  def cover_letters
    authorize! unless id == "me"

    @user.cover_letter.attach(params[:user][:cover_letter])
    render status: 201, jsonapi: @user, include: %i[curriculum_vitae cover_letter]
  end

  private

  def set_user
    @user = current_user and return if id == "me"
    render status: 404, json: { error: I18n.t('users.not_found') } and return unless User.exists?(id)

    @user = User.with_attached_curriculum_vitae.find(id)
  end

  def user_params
    params
      .require(:user)
      .permit(:first_name, :last_name, :email, :pav_until, :driving_licence_since, :password)
  end

  def id
    params[:id]
  end
end