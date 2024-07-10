# frozen_string_literal: true

# == Schema Information
#
# Table name: collections
#
#  id                     :bigint           not null, primary key
#  account_id             :bigint           not null
#  public                 :boolean          default(TRUE), not null
#  collectable_maps_count :integer          default(0), not null
#  title                  :string           not null
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Collection < ApplicationRecord
  belongs_to :account

  has_many :collectable_maps, dependent: :destroy

  has_many :flash_cards, through: :collectable_maps, source: :collectable, source_type: 'FlashCard'
  has_many :quizzes, through: :collectable_maps, source: :collectable, source_type: 'Quiz'

  validates :public, boolean: true
  validates :title, presence: true
end
