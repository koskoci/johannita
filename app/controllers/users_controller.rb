class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  deserializable_resource :user, only: %i[create update]
  before_action :set_user_with_attachments, only: %i[show]
  before_action :set_user, only: %i[update destroy curriculum_vitaes cover_letters]

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

  def create
    confirm_token = SecureRandom.urlsafe_base64.to_s
    @user = User.new(user_params.merge(confirm_token: confirm_token))

    if @user.save
      EmailConfirmationMailer.with(user: @user).call.deliver_now
      head 204
    else
      render status: 400, json: { error: @user.errors.full_messages }
    end
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
      head 204
    else
      render status: 400, json: { error: @user.errors }
    end
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

  def set_user_with_attachments
    @user = current_user and return if id == "me"
    render status: 404, json: { error: I18n.t('users.not_found') } and return unless User.exists?(id)

    @user = User.with_attached_curriculum_vitae.with_attached_cover_letter.find(id)
  end

  def set_user
    @user = current_user and return if id == "me"
    render status: 404, json: { error: I18n.t('users.not_found') } and return unless User.exists?(id)

    @user = User.find(id)
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