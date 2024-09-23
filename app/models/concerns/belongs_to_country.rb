# frozen_string_literal: true

# Models using this concern must have country_name and country_alpha2 columns
module BelongsToCountry
  extend ActiveSupport::Concern

  included do
    validates :country_name, :country_alpha2, presence: true

    def country = Country[country_alpha2]
  end
end
