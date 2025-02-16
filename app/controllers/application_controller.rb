class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def user_not_authorized(exception)
    Rails.logger.error("User with id #{current_user.id} tried to access a page they are not authorized to access: #{exception}")
    redirect_to(request.referrer || root_path)
  end

  def record_not_found(exception)
    Rails.logger.error("User with id #{current_user.id} tried to access a record that does not exist: #{exception}")
    redirect_to root_path
  end
end
