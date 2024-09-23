# frozen_string_literal: true

class RawText < ApplicationRecord
  TRANSFORM_MODELS = %w[CountryNewsHeadline].freeze

  alias_attribute :multiline_text, :needs_separator

  validates :becomes_into, inclusion: { in: TRANSFORM_MODELS }, if: :becomes_into?
  validates :needs_separator, boolean: true
  validates :raw_text, presence: true
  validates :record_identifier, presence: true
  validates :separator, presence: true, if: :needs_separator?
end
