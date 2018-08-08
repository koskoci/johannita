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
    @current_user = Authentication::DecodeAuthenticationCommand.call(request.headers).result
    raise NotAuthneticatedException unless @current_user
  end
end
