class RequestLog < ApplicationRecord
  belongs_to :account, optional: true

  validates_presence_of :action, :controller, :original_url
end
