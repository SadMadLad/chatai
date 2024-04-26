# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  retry_on ActiveRecord::Deadlocked

  def log_error(error_translation)
    logger.error t(error_translation, job: self.class.name)
  end
end
