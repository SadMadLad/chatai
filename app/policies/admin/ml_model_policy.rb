# frozen_string_literal: true

module Admin
  class MlModelPolicy < AdminPolicy
    RESOURCEFUL_ACTIONS.each do |action|
      define_method(:"#{action}?") do
        user.superadmin?
      end
    end
  end
end
