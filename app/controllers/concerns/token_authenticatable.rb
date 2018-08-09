class NotAuthneticatedException < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate_user

    rescue_from NotAuthneticatedException, with: -> { render json: { error: command.errors }, status: 401 }
  end

  private

  def authenticate_user
    @current_user = command.result
    raise NotAuthneticatedException unless @current_user
  end

  def command
    @_command ||= Authentication::DecodeAuthenticationCommand.call(request.headers)
  end
end
