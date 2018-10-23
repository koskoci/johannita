class EmailConfirmationController < ApplicationController
  skip_before_action :authenticate_user

  def show
    @confirm_token = params[:id]

    render status: 418, json: { error: I18n.t('email_confirmation.already_confirmed') } and return unless user

    User.find(user.id).update(email_confirmed: true, confirm_token: nil)
    render status: 200, json: { token: auth_token }
  end

  private

  attr_reader :confirm_token

  def user
    @_user ||= User.find_by_confirm_token(confirm_token)
  end

  def auth_token
    Authentication::Jwt.encode(contents)
  end

  def contents
    {
      user_id: user.id,
      exp: 24.years.from_now.to_i
    }
  end
end