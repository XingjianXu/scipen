class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  add_breadcrumb 'Home', :root_path

end
