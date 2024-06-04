# frozen_string_literal: true

# User Comment to a post or as a reply.
class Comment < ApplicationRecord
  attr_accessor :depth

  belongs_to :account
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :replies, class_name: 'Comment', as: :commentable, dependent: :destroy

  validates :body, presence: true

  def recursive_count
    return 0 if replies.blank?

    replies_count = replies.length
    replies.each do |reply|
      replies_count += reply.recursive_count
    end
    replies_count
  end

  class << self
    def recursive_count
      replies_count = 0

      find_each do |comment|
        replies_count += comment.recursive_count
      end

      replies_count
    end

    def deep_includes(levels: 5)
      includes(
        {
          replies: [
            :likes,
            { account: { avatar_attachment: :blob } },
            { replies: deep_includes_nested_hash(levels) }
          ]
        },
        :likes, account: { avatar_attachment: :blob }
      )
    end

    def deep_includes_nested_hash(levels)
      return :replies if levels.zero?

      {
        likes: [],
        account: { avatar_attachment: :blob },
        replies: deep_includes_nested_hash(levels - 1)
      }
    end
  end
end
