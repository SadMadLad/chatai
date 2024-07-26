class CreateRequestLogJob < ApplicationJob
  def perform(request_url, params, account, user)
    RequestLog.create(
      original_url: request_url,
      account:,
      user:,
      controller: params[:controller],
      action: params[:action],
      extra_params: params.except(:action, :controller)
    )
  end
end
