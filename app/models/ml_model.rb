# frozen_string_literal: true

class MlModel < ApplicationRecord
  belongs_to :account

  has_one_attached :model_diagram
  has_one_attached :notebook
  has_rich_text :explanation

  validates :title, :parameters, :description, :config, :explanation, presence: true
end
