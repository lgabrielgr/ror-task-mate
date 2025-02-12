class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    Rails.logger.error("User with id #{current_user.id} tried to access a page they are not authorized to access: #{exception}")
    redirect_to(request.referrer || root_path)
  end
end
