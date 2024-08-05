# frozen_string_literal: true

class CreateRequestLogJob < ApplicationJob
  def perform(full_url, params, account, db_runtime, view_runtime, status, remote_ip, user_agent)
    controller, action = params.values_at(:controller, :action)
    extra_params = params.except(:action, :controller)
    total_runtime = db_runtime + view_runtime

    user = account&.user
    user_email = user&.email

    RequestLog.create(
      account:, action:, controller:, db_runtime:, extra_params:, full_url:, remote_ip:,
      status:, total_runtime:, user:, user_agent:, user_email:, view_runtime:, 
    )
  end
end
