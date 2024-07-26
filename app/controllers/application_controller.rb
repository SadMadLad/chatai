# frozen_string_literal: true

# Base Controller.
class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  attr_reader :model

  helper_method :current_account

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :log_request

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    current_account
  end

  protected

  def log_request
    CreateRequestLogJob.perform_later(
      request.original_url, params.to_unsafe_h, current_account, db_runtime, view_runtime, response.status
    )
  end

  def define_model_name(model_name)
    @model = model_name
  end

  def user_not_authorized
    flash[:alert] = t(:unauthorized)

    redirect_back fallback_location: dashboard_path
  end

  def current_account
    @current_account ||= current_user&.account
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [account_attributes: %i[first_name last_name username]])
  end

  def after_sign_in_path_for(resource)
    resource.account.can_moderate? ? %i[admin dashboard] : :dashboard
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
