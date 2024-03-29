class ApplicationController < ActionController::Base
  helper_method :retrieve_last_page_or_default

  def store_last_page
    session[:last_page] = request.fullpath
  end

  def retrieve_last_page_or_default(default_path: root_path)
    session[:last_page] || default_path
  end
end
