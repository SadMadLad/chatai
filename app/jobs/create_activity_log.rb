# frozen_string_literal: true

# Create Activity Log
class CreateActivityLog < ApplicationJob
  def perform(activity_loggable, log_text)
    account = activity_loggable.account

    return if account.blank? || log_text.blank?

    ActivityLog.create(activity_loggable:, log_text:, account:)

    activity_loggable.create_log_text = nil
    activity_loggable.destroy_log_text = nil
  end
end
