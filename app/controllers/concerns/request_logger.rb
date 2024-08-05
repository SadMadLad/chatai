# frozen_string_literal: true

# Concern for controller
module RequestLogger
  extend ActiveSupport::Concern

  included do
    after_action :log_request

    def log_request
      CreateRequestLogJob.perform_later(
        request.original_url, params.to_unsafe_h, current_account, db_runtime, view_runtime, response.status,
        request.remote_ip, request.user_agent
      )
    end
  end
end
