# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                :bigint           not null, primary key
#  user_id           :bigint           not null
#  role              :integer          default("user"), not null
#  first_name        :string           not null
#  last_name         :string           not null
#  username          :string           not null
#  tagline           :text
#  latest_message_at :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# A User Account
class Account < ApplicationRecord
  include SearchBy

  has_many :account_chat_maps, dependent: :destroy
  has_many :account_tokens, dependent: :destroy
  has_many :chats, through: :account_chat_maps
  has_many :comments, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :ml_models, dependent: :destroy
  has_many :overseer_comments, class_name: 'AdminComment', foreign_key: 'commenter_id', dependent: :destroy,
                               inverse_of: :commenter
  has_many :posts, dependent: :destroy
  has_many :quizzes, dependent: :nullify
  has_many :quiz_undertakings, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :taken_quizzes, through: :quiz_undertakings, class_name: 'Quiz'

  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100], preprocessed: true
  end

  belongs_to :user, dependent: :destroy

  enum :role, { user: 0, admin: 1, superadmin: 2 }

  scope :admins, -> { where(role: %i[superadmin admin]) }

  validates :first_name, :last_name, :role, :username, presence: true
  validates :username, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def initials
    [first_name, last_name].map { |name| name.first.upcase }.join(' ')
  end

  def can_moderate?
    admin? || superadmin?
  end

  def sidebar_stream_id(chat_type: :two_person)
    "account_#{id}_chat_sidebar#{'_group' if chat_type == :multi_person}"
  end

  def account_stats
    {
      chats_count: chats.count,
      comments_count: comments.count,
      likes_count: likes.count,
      posts_count: posts.count
    }
  end

  class << self
    def conversing_accounts(account, chats)
      joins(:chats)
        .where(chats: { id: chats })
        .excluding(account)
        .order('chats.latest_message_at DESC')
    end
  end
end
