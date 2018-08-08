class ApplicationController < ActionController::Base
  include TokenAuthenticatable
  include AdminAuthorizable

  protect_from_forgery unless: -> { request.format.json? }
end
