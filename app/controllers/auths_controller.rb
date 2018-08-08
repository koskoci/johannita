class AuthsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    token_command = Authentication::AuthenticateCommand.call(*params.slice(:user, :password).values)

    if token_command.success?
      render json: { token: token_command.result }
    else
      render json: { error: token_command.errors }, status: :unauthorized
    end
  end
end
