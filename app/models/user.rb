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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  DEVISE_MODULES = %i[database_authenticatable registerable recoverable rememberable trackable validatable].freeze

  devise(*DEVISE_MODULES)

  has_one :account, dependent: :destroy

  %i[
    account_tokens account_chat_maps chats collections comments feedback favorites likes messages ml_models 
    quiz_undertakings posts ratings
  ].each do |associated_records|
    has_many associated_records, through: :account, dependent: :destroy
  end

  %i[flash_cards quizzes].each do |associated_records|
    has_many associated_records, through: :account, dependent: :nullify
  end

  scope :admins, -> { where(role: %i[superadmin admin]) }

  validates_associated :account
  accepts_nested_attributes_for :account
end
