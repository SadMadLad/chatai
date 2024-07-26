class CreateRequestLogJob < ApplicationJob
  def perform(full_url, params, account, db_runtime, view_runtime, status)
    controller, action = params.values_at(:controller, :action)
    extra_params = params.except(:action, :controller)
    total_runtime = db_runtime + view_runtime

    user = account&.user
    user_email = user&.email

    RequestLog.create(
      account:, action:, controller:, db_runtime:, extra_params:, full_url:,
      status:, total_runtime:, user:, user_email:, view_runtime:
    )
  end
end
