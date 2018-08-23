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
    authorize! unless its_me

    respond_to do |format|
      format.html
      format.json { render jsonapi: @user }
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize! unless its_me

    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    authorize!

    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params
        .require(:user)
        .permit(
          :first_name, :last_name, :email, :pav,
          :pav_date, :driving_licence, :driving_licence_date
        )
    end

    def its_me
      current_user.id == params[:id].to_i
    end
  end
