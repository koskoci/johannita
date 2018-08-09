class NotAuthneticatedException < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate_user

    rescue_from NotAuthneticatedException, with: -> { render json: { error: 'Not Authenticated' }, status: 401 }
  end

  private

  def authenticate_user
    command = Authentication::DecodeAuthenticationCommand.call(request.headers)
    command.errors || @current_user = command.result
  end
end
