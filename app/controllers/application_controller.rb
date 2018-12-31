# frozen_string_literal: true

class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env == 'production'
  protect_from_forgery with: :exception
  include SessionsHelper

  class Forbidden < ActionController::ActionControllerError; end
  rescue_from Forbidden, with: :rescue403

  def rescue403(e)
    @ex = e
    render 'errors/forbidden', status: 403, layout: nil
  end
end
