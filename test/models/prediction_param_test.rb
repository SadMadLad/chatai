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
require "test_helper"

class PredictionParamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
