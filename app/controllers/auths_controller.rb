class AuthsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    token_command = Authentication::AuthenticateCommand.call(*params.slice(:user, :password).values)

    if token_command.success?
      render status: 200, json: { token: token_command.result }
    else
      render status: 401, json: { error: token_command.errors }
    end
  end
end
