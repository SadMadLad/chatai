# frozen_string_literal: true

class CountryNewsHeadline < ApplicationRecord
  include BelongsToCountry

  validates :headline, presence: true

  class << self
  end
end
