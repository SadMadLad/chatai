class CreateRequestLogJob < ApplicationJob
  def perform(full_url, params, account)
    controller, action = params.values_at(:controller, :action)
    extra_params = params.except(:action, :controller)

    user = account&.user
    user_email = user&.email

    RequestLog.create(full_url:, account:, controller:, action:, extra_params:, user:, user_email:)
  end
end
