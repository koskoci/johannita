class ApplicationController < ActionController::Base
  include TokenAuthenticatable
  include AdminAuthorizable

  protect_from_forgery unless: -> { request.format.json? }

  before_action :set_headers

  def set_headers
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

  def jsonapi_class
    super.merge({
      'ActiveStorage::Attachment': SerializableAttachment,
      'ActiveStorage::Attached::One': SerializableAttachment
    })
  end
end
