class ApplicationController < ActionController::Base
  include TokenAuthenticatable
  include AdminAuthorizable

  protect_from_forgery unless: -> { request.format.json? }

  def jsonapi_class
    super.merge(
      'ActiveStorage::Attachment': SerializableAttachment
    )
  end
end
