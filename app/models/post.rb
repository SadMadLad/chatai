# frozen_string_literal: true

# User Post
class Post < ApplicationRecord
  belongs_to :account

  has_many_attached :images
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  class << self
    def eager_load_everything
      includes(images_attachments: :blob).includes(:likes).includes(:account)
    end
  end
end
