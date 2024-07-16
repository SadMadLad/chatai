# == Schema Information
#
# Table name: embeddings
#
#  id              :bigint           not null, primary key
#  embeddable_type :string           not null
#  embeddable_id   :bigint           not null
#  embedding       :vector(768)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class EmbeddingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
