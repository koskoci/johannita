class AuthsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    if token_command.success?
      render status: 422, json: { error: I18n.t('auths.email_unconfirmed') } and return unless email_confirmed
      render status: 200, json: { token: token_command.result }
    else
      render status: 401, json: { error: token_command.errors }
    end
  end

  private

  def email_confirmed
    user_id = Authentication::Jwt.decode(token_command.result).fetch("user_id")
    User.find(user_id).email_confirmed
  end

  def token_command
    Authentication::AuthenticateCommand.call(*params.slice(:user, :password).values)
  end
end
