class ApplicationController < ActionController::Base
  include TokenAuthenticatable

  protect_from_forgery unless: -> { request.format.json? }
end
