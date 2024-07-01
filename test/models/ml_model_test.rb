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
require "test_helper"

class MlModelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
