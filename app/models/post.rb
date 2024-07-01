# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  body       :text             not null
#  account_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
      includes({ account: { avatar_attachment: :blob } }, { images_attachments: :blob }).all
    end

    def order_by_most_likes
      order(likes_count: :desc)
    end
  end
end
