# frozen_string_literal: true

module Admin
  # Machine Learning Model Policy.
  class MlModelPolicy < AdminPolicy
    RESOURCEFUL_ACTIONS + %w[notebook_html prediction].each do |action|
      define_method(:"#{action}?") do
        user.superadmin?
      end
    end
  end
end
