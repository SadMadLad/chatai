# frozen_string_literal: true

module Ai
  # Machine Learning model are simple scikit models.
  class MlModel < ApplicationRecord
    has_many :prediction_params, dependent: :destroy
    belongs_to :account

    has_one_attached :model_diagram
    has_rich_text :explanation

    enum :model_type, { classification: 0, regression: 1 }

    validates :description, :explanation, :identifier, :model_type, :parameters_with_order, :title, presence: true
    validates :identifier, downcase: true, alphanumeric: true, length: { minimum: 2, maxiumum: 60 }
  end
end
