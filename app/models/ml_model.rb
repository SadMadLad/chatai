# frozen_string_literal: true

class MlModel < ApplicationRecord
  belongs_to :account

  has_one_attached :model_diagram
  has_one_attached :notebook
  has_one_attached :notebook_html
  has_rich_text :explanation

  enum :model_type, { classification: 0, regression: 1 }

  validates :title, :description, :model_type, :identifier, :explanation, :parameters_with_order, presence: true
  validates :identifier, downcase: true, alphanumeric: true, length: { minimum: 2, maxiumum: 60 }
end
