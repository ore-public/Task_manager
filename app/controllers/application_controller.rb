class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  protect_from_forgery with: :exception
  include SessionsHelper

end
  #adminuser 以外のアクセスで専用例外ページを作成中
  # class Forbidden < ActionController::ActionControllerError; end
  # rescue_from Forbidden, with: :rescue403
  #
  # def rescue403(e)
  #   @ex = e
  #   render "errors/forbidden", status: 403
  # end
