# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :account_chat_maps, dependent: :destroy
  has_many :chats, through: :account_chat_maps
  has_many :comments, class_name: 'AdminComment', foreign_key: 'commenter_id', dependent: :destroy,
                      inverse_of: :commenter
  has_many :messages, dependent: :destroy
  has_many :ml_models, dependent: :destroy

  belongs_to :user, dependent: :destroy

  enum :role, { user: 0, admin: 1, superadmin: 2 }

  scope :admins, -> { where(role: %i[superadmin admin]) }

  validates :first_name, :last_name, :role, :username, presence: true
  validates :username, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_moderate?
    admin? || superadmin?
  end

  class << self
    def conversing_accounts(account, chats)
      joins(:chats)
        .where(chats: { id: chats })
        .where.not(id: account.id)
        .order('chats.latest_message_at DESC')
    end
  end
end
