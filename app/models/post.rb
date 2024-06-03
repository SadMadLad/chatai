# frozen_string_literal: true

# User Post
class Post < ApplicationRecord
  belongs_to :account

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :replies, through: :comments
  has_many :likes, as: :likeable, dependent: :destroy

  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true

  class << self
    def eager_load_everything(without_replies: true)
      includes(:likes, { account: { avatar_attachment: :blob } }, { images_attachments: :blob }).all
    end
  end
end
