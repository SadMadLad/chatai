# frozen_string_literal: true

# == Schema Information
#
# Table name: ratings
#
#  id            :bigint           not null, primary key
#  account_id    :bigint           not null
#  rateable_type :string           not null
#  rateable_id   :bigint           not null
#  rating        :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Rating < ApplicationRecord
  belongs_to :rateable, polymorphic: true, counter_cache: :ratings_count
  belongs_to :account

  after_commit :increase_total_rating_count, on: :create
  after_commit :decrease_total_rating_count, on: :destroy

  validates :rating, presence: true, comparison: { greater_than: 0, less_than_or_equal_to: 5 }

  def increase_total_rating_count
    the_rateable = rateable
    return unless the_rateable.has_attribute?(:total_rating)

    the_rateable.update(total_rating: the_rateable.total_rating + rating)
  end

  def decrease_total_rating_count
    the_rateable = rateable
    return unless the_rateable.has_attribute?(:total_rating)

    the_rateable.update(total_rating: the_rateable.total_rating - rating)
  end
end
