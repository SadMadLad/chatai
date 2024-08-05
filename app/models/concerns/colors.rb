# frozen_string_literal: true

# Colors Concern
module Colors
  extend ActiveSupport::Concern

  COLORS = %w[
    slate gray zinc neutral stone red orange amber yellow lime green emerald teal cyan sky blue
    indigo violet purple fuchsia pink rose
  ].freeze

  included do
    validates :color, presence: true, inclusion: { in: COLORS }
  end
end
