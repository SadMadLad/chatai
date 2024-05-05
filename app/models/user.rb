# frozen_string_literal: true

# A Devise User.
# Each User must have an accounts.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  DEVISE_MODULES = %i[database_authenticatable registerable recoverable rememberable trackable validatable].freeze

  Warden::Manager.after_authentication do |user, _auth, _opts|
    user.account.update(:active_at_chatai, true)
  end

  Warden::Manager.before_logout do |user, _auth, _opts|
    user.account.update(:active_at_chatai, false)
  end

  devise(*DEVISE_MODULES)

  has_one :account, dependent: :destroy

  has_many :account_tokens, through: :account, dependent: :destroy
  has_many :chats, through: :account, dependent: :destroy
  has_many :feedback, through: :account, dependent: :destroy
  has_many :messages, through: :account, dependent: :destroy
  has_many :ml_models, through: :account, dependent: :destroy

  scope :admins, -> { where(role: %i[superadmin admin]) }

  validates_associated :account
  accepts_nested_attributes_for :account
end
