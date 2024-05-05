# frozen_string_literal: true

# Base Controller.
class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  attr_reader :model

  helper_method :current_account

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    current_account
  end

  protected

  def define_model_name(model_name)
    @model = model_name
  end

  def user_not_authorized
    flash.now[:alert] = t(:unauthorized)

    render turbo_stream: turbo_stream.append('flash', partial: 'shared/flash'), status: :unauthorized
  end

  def current_account
    @current_account ||= current_user.account
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [account_attributes: %i[first_name last_name username]])
  end

  def after_sign_in_path_for(resource)
    resource.account.can_moderate? ? %i[admin dashboard] : :dashboard
  end
end
