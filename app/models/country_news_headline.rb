# frozen_string_literal: true

class CountryNewsHeadline < ApplicationRecord
  include BelongsToCountry

  validates :headline, :description, presence: true
end
