# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# A Devise User. Each user must have an account.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  DEVISE_MODULES = %i[database_authenticatable registerable recoverable rememberable trackable validatable].freeze

  devise(*DEVISE_MODULES)

  has_one :account, dependent: :destroy

  has_many :account_tokens, through: :account, dependent: :destroy
  has_many :chats, through: :account, dependent: :destroy
  has_many :feedback, through: :account, dependent: :destroy
  has_many :likes, through: :account, dependent: :destroy
  has_many :posts, through: :account, dependent: :destroy
  has_many :messages, through: :account, dependent: :destroy
  has_many :ml_models, through: :account, dependent: :destroy
  has_many :quizzes, through: :account, dependent: :destroy
  has_many :quiz_undertakings, through: :account, dependent: :destroy

  scope :admins, -> { where(role: %i[superadmin admin]) }

  validates_associated :account
  accepts_nested_attributes_for :account
end
