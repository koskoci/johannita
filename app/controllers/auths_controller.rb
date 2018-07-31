class AuthsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    token_command = Authentication::Authenticate.call(*params.slice(:user, :password).values)

    if token_command.success?
      render json: { token: token_command.result }
    else
      render json: { error: token_command.errors }, status: :unauthorized
    end
  end
end
