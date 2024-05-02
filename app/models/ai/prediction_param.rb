# frozen_string_literal: true

module Ai
  class PredictionParam < ApplicationRecord
    belongs_to :ml_model

    validates :name, :param_type, :description, presence: true
    validates :name, uniqueness: true

    enum :param_type, { integer: 0, float: 1, string: 2, json: 3, text: 5, options: 6, image: 7 }
  end
end
