# frozen_string_literal: true

# == Schema Information
#
# Table name: prediction_params
#
#  id              :bigint           not null, primary key
#  ml_model_id     :bigint           not null
#  param_type      :integer          not null
#  name            :string           not null
#  description     :text             not null
#  possible_values :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class PredictionParam < ApplicationRecord
  belongs_to :ml_model

  validates :name, :param_type, :description, presence: true
  validates :name, uniqueness: true
  validates :possible_values, presence: true, if: :options?

  enum :param_type, { integer: 0, float: 1, string: 2, json: 3, text: 5, options: 6, image: 7 }
end
