class NotAuthenticatedException < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate_user

    rescue_from NotAuthenticatedException, with: -> { render status: 401, json: { error: command.errors } }
  end

  private

  def authenticate_user
    @current_user = command.result
    raise NotAuthenticatedException unless @current_user
  end

  def command
    @_command ||= Authentication::DecodeAuthenticationCommand.call(request.headers)
  end
end
