# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  account_id       :bigint           not null
#  commentable_type :string           not null
#  commentable_id   :bigint           not null
#  likes_count      :integer          default(0), not null
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
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
      return :replies if levels <= 0

      {
        likes: [],
        account: { avatar_attachment: :blob },
        replies: deep_includes_nested_hash(levels - 1)
      }
    end
  end
end
