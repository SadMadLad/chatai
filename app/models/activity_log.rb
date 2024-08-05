# frozen_string_literal: true

# User Activity Log
class ActivityLog < ApplicationRecord
  belongs_to :account
  belongs_to :activity_loggable, polymorphic: true

  validates :log_text, presence: true
  validates :visible, boolean: true
end
