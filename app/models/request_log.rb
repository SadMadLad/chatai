# frozen_string_literal: true

# == Schema Information
#
# Table name: request_logs
#
#  id             :bigint           not null, primary key
#  account_id     :bigint
#  user_id        :bigint
#  should_be_kept :boolean          default(FALSE), not null
#  status         :integer          not null
#  db_runtime     :float            not null
#  total_runtime  :float            not null
#  view_runtime   :float            not null
#  action         :string           not null
#  controller     :string           not null
#  full_url       :string           not null
#  user_email     :string
#  extra_params   :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class RequestLog < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :user, optional: true

  validates :action, :controller, :db_runtime, :full_url, :view_runtime, presence: true
  validates :preserve, boolean: true

  def constantized_controller = "#{controller}_controller".camelize.constantize

  def assumed_active_record
    controller.split('/').last.singularize.camelize.constantize
  rescue StandardError
    'Active Record not found'
  end
end
