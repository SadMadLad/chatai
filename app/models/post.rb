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
    def eager_load_everything
      includes(:likes, { account: { avatar_attachment: :blob } }, { images_attachments: :blob }).all
    end

    def order_by_most_likes
      left_joins(:likes).group(:id).order('COUNT(likes.id) DESC')
    end
  end
end