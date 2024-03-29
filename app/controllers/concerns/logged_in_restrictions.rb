module LoggedInRestrictions
  extend ActiveSupport::Concern
  include SessionsHelper

  included do
    before_action :logged_in_user
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url, status: :see_other
    end
  end
end
