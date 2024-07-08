# frozen_string_literal: true

# == Schema Information
#
# Table name: ml_models
#
#  id                    :bigint           not null, primary key
#  account_id            :bigint           not null
#  model_type            :integer          not null
#  identifier            :string           not null
#  title                 :string           not null
#  description           :text             not null
#  parameters_with_order :jsonb            not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class MlModel < ApplicationRecord
  AVAILABLE_MODELS = %w[titanic].freeze
  has_many :prediction_params, dependent: :destroy
  belongs_to :account

  has_one_attached :model_diagram
  has_rich_text :explanation

  enum :model_type, { classification: 0, regression: 1 }

  validates :description, :explanation, :identifier, :model_type, :parameters_with_order, :title, presence: true
  validates :identifier, downcase: true, alphanumeric: true, length: { in: 2..60 },
                         single_word: true, inclusion: { in: AVAILABLE_MODELS }
end
