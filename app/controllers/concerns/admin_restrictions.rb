module AdminRestrictions
  extend ActiveSupport::Concern
  include SessionsHelper

  included do
    before_action :restrict_to_admin
  end

  def restrict_to_admin
    unless current_user.try(:is_admin?)
      redirect_to root_url
      flash[:danger] = "You are not authorized to access this page."
    end
  end
end
