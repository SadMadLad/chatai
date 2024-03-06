# frozen_string_literal: true

module Admin
  class AdminCommentPolicy < AdminPolicy
    %i[edit update destroy].each do |action|
      define_method(:"#{action}?") { authorized_record? }
    end
  end
end
