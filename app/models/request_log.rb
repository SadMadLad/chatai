class RequestLog < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :user, optional: true

  validates_presence_of :action, :controller, :db_runtime, :full_url, :view_runtime
end
