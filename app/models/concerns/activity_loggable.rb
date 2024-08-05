# frozen_string_literal: true

# Concern for models which can be included as account activity
module ActivityLoggable
  extend ActiveSupport::Concern

  included do
    attr_accessor :create_log_text, :destroy_log_text

    has_many :activity_logs, as: :activity_loggable, dependent: :destroy

    after_create_commit -> { create_activity_log(create_log_text) }
    after_destroy_commit -> { create_activity_log(destroy_log_text) }

    def create_activity_log(log_text)
      return if log_text.blank?

      CreateActivityLog.new.perform(self, log_text)
    end
  end
end
