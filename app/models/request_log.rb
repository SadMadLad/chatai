# frozen_string_literal: true

class RequestLog < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :user, optional: true

  validates :action, :controller, :db_runtime, :full_url, :view_runtime, presence: true
  validates :should_be_kept, boolean: true

  def constantized_controller = "#{controller}_controller".camelize.constantize

  def assumed_active_record
    controller.split('/').last.singularize.camelize.constantize
  rescue StandardError
    'Active Record not found'
  end
end
