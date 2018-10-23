class NotPermittedException < StandardError; end

module AdminAuthorizable
  extend ActiveSupport::Concern

  included do
    rescue_from NotPermittedException, with: -> { render status: 403, json: { error: 'Not Permitted' } }
  end

  def authorize!
    raise NotPermittedException unless current_user.admin?
    true
  end
end
