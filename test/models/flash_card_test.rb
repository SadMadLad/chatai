# == Schema Information
#
# Table name: flash_cards
#
#  id                     :bigint           not null, primary key
#  account_id             :bigint
#  card_style             :integer          default("basic"), not null
#  collectable_maps_count :integer          default(0), not null
#  favorites_count        :integer          default(0), not null
#  color                  :string           default("#84cc16"), not null
#  answer                 :text             not null
#  prompt                 :text             not null
#  published              :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class FlashCardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
